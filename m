Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932748AbVITGvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbVITGvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 02:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932745AbVITGvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 02:51:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36295 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932744AbVITGvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 02:51:45 -0400
Date: Tue, 20 Sep 2005 07:51:42 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Ram <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: Re: [RFC PATCH 4/10] vfs: global namespace semaphore
Message-ID: <20050920065142.GH7992@ftp.linux.org.uk>
References: <20050916182619.GA28474@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916182619.GA28474@RAM>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 11:26:19AM -0700, Ram wrote:
> This patch removes the per-namespace semaphore in favor of a global
> semaphore.  This can have an effect on namespace scalability.

... and #2 uses that semaphore...
