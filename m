Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270412AbTGUQUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270429AbTGUQUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:20:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:19128 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270412AbTGUQUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:20:09 -0400
Date: Mon, 21 Jul 2003 12:27:39 -0400
From: Greg KH <greg@kroah.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [RFC/PATCH] 1/2 v4l: sysfs'ify video4linux core
Message-ID: <20030721162739.GA10770@kroah.com>
References: <20030716202018.GC26510@bytesex.org> <20030716210800.GE2279@kroah.com> <20030717120121.GA15061@bytesex.org> <20030717145749.GA5067@kroah.com> <20030717163715.GA19258@bytesex.org> <20030717214907.GA3255@kroah.com> <20030718095920.GA32558@bytesex.org> <20030718234359.GK1583@kroah.com> <20030721072853.GA21450@bytesex.org> <20030721154340.GA13871@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030721154340.GA13871@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 05:43:40PM +0200, Gerd Knorr wrote:
> > New patch will come later today or early next week.
> 
> Here we go.  Changes:
> 
>  * dropped /proc support from videodev.c
>  * added sysfs support to videodev.c
>  * added a number of helper functions for v4l
>    drivers.
> 
> v4l drivers will continue to work, but must be adapted to be
> race-free[tm].  videodev.o will print a warning on not-yet
> fixed drivers.

Very nice, looks good to me.  Thanks for putting up with the lack of
documentation for some of this :)

thanks,

greg k-h
