Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVLMNrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVLMNrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVLMNrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:47:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:8661 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932234AbVLMNrF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:47:05 -0500
Date: Tue, 13 Dec 2005 13:46:53 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: JANAK DESAI <janak@us.ibm.com>
Cc: chrisw@osdl.org, dwmw2@infradead.org, jamie@shareable.org,
       serue@us.ibm.com, mingo@elte.hu, linuxram@us.ibm.com, jmorris@namei.org,
       sds@tycho.nsa.gov, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 6/9] unshare system call : allow unsharing of fs structure
Message-ID: <20051213134653.GO27946@ftp.linux.org.uk>
References: <1134442698.14136.123.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134442698.14136.123.camel@hobbs.atlanta.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 10:00:07PM -0500, JANAK DESAI wrote:
> +		new_fs = __copy_fs_struct(current->fs);
		*new_fsp = __copy_fs_struct(current->fs);

no need of local variables...
