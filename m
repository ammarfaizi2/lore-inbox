Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTJQFBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 01:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbTJQFBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 01:01:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:57988 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263303AbTJQFBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 01:01:54 -0400
Date: Thu, 16 Oct 2003 21:34:16 -0700
From: Greg KH <greg@kroah.com>
To: Ian Kent <raven@themaw.net>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: devfs vs. udev
Message-ID: <20031017043416.GA6735@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <yw1xekxpdtuq.fsf@users.sourceforge.net> <Pine.LNX.4.44.0310142145410.3044-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310142145410.3044-100000@raven.themaw.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 09:51:43PM +0800, Ian Kent wrote:
> 
> 2) I believe udev does not support for an increased number of anonymous 
> devices for such things as NFS and autofs mounts. I can't see anything in 
> the kernel (2.6) to improve this either. Can devfs provide improvements 
> for this without to much pain?

udev has no control over this.  If the kernel supports an increased
number, udev will support it.  The number of raw devices has recently
been increased, due to the new major/minor increase.  Such a patch for
anonymous devices could probably be easily created.

Hope this helps,

greg k-h
