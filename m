Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWDXW2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWDXW2j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWDXW2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:28:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751332AbWDXW2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:28:38 -0400
Date: Mon, 24 Apr 2006 15:31:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs removal patches for -mm
Message-Id: <20060424153103.64178e17.akpm@osdl.org>
In-Reply-To: <20060424213245.GA28618@kroah.com>
References: <20060424213245.GA28618@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> Could you please add my "remove devfs" series of patches to the -mm
> tree?  They are contained in:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/

That seems to go in OK.  The only patch-time clash with pending subsystem
trees is in drivers/s390/net/ctctty.c, which was removed in Jeff's
git-netdev-all.patch.
