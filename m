Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVAXIOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVAXIOz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 03:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVAXIOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 03:14:55 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:31242 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261460AbVAXIOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 03:14:54 -0500
Date: Mon, 24 Jan 2005 09:14:49 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Alessandro Sappia <a.sappia@ngi.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: chvt issue
Message-ID: <20050124081449.GA2650@pclin040.win.tue.nl>
References: <41F442B0.80900@ngi.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F442B0.80900@ngi.it>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: pastinakel.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 01:34:56AM +0100, Alessandro Sappia wrote:

> I was reading vt driver
> and I saw
>         /*
>          * To have permissions to do most of the vt ioctls, we either have
>          * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.
>          */
>         perm = 0;
>         if (current->signal->tty == tty || capable(CAP_SYS_TTY_CONFIG))
>                 perm = 1;
> 
> (lines 382-388 - drivers/char/vt_ioctl.c)
> 
> After reading the comment I thinked I can change vt
> from one of my own to another one of mine.

Yes, the comment. But you should read the code instead.
