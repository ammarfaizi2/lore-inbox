Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVCISYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVCISYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVCISYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:24:36 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:20769 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262167AbVCISXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:23:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=t0ogW0ArjSpdsh/Xuqu+0mMBkgFknffhudTJOc83SHta8f4jNO5MzqCEsEhHtQEe+ZtgAv70R/ycv69S9slZg4LZKjewir8J4W9X491xBKmftIUyLVV2YRcbkrc4rpiuv7sMRXrPYN/MCviFEg6yGmBRERFAKxtfkrd3XyHRUP4=
Message-ID: <9e4733910503091023474eb377@mail.gmail.com>
Date: Wed, 9 Mar 2005 13:23:49 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: current linus bk, error mounting root
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <422F2F7C.3010605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105030909031486744f@mail.gmail.com>
	 <422F2F7C.3010605@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2005 12:16:44 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Jon Smirl wrote:
> > Something in the last 24hrs in linus bk broke my ability to mount root:
> >
> > Creating root device
> > Mounting root filesystem
> > mount: error 6 mounting ext3
> > mount: error 2 mounting none
> > Switching to new root
> > Switchroot: mount failed 22
> > umount /initrd/dev failed: 2
> >
> > If I back off a day everything works again.
> >
> > Root is on Intel ICH5 SATA drive.
> 
> dmesg output?
> 
> Can you verify that -bk4 works, and -bk5 breaks?

bk4 works. I don't have a serial port hooked up so there is no way to
get dmesg, but I don't see anything obvious on the screen scrolling
by.

I'll check bk5 next.

It would be much more convenient if the bkN releases were tagged in Linus bk.

> 
>         Jeff
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
