Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVC1AyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVC1AyC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 19:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVC1AyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 19:54:02 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:25785 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261641AbVC1Ax7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 19:53:59 -0500
Date: Sun, 27 Mar 2005 16:53:47 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Greg KH <greg@kroah.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Mark Fortescue <mark@mtfhpc.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050328005347.GA32265@taniwha.stupidest.org>
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk> <20050326182828.GA8540@kroah.com> <1111869274.32641.0.camel@mindpipe> <20050327004801.GA610@kroah.com> <1111885480.1312.9.camel@mindpipe> <20050327032059.GA31389@kroah.com> <1111894220.1312.29.camel@mindpipe> <20050327181056.GA14502@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327181056.GA14502@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 10:10:56AM -0800, Greg KH wrote:

> How about the fact that when you load a kernel module, it is linked
> into the main kernel image?  The GPL explicitly states what needs to
> be done for code linked in.

oddly, the close nv driver has like 2.4MB if text in the kernel.  i
suspect a good chunk of this really should be in userspace but
probably lives in the kernel because 'the windows driver does that'

if the in-kernel part was trimmed down it would be nice for nv to move
the resource manager and whatever else lives in their gigantic module
(larger than most kernels!) to userspace and side-step the entire
issue completely

> Also, realize that you have to use GPL licensed header files to
> build your kernel module...

people could make their own.  i'm not sure if anyone has though.
