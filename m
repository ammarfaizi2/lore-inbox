Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280277AbRJaPzI>; Wed, 31 Oct 2001 10:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280247AbRJaPyu>; Wed, 31 Oct 2001 10:54:50 -0500
Received: from zero.tech9.net ([209.61.188.187]:1037 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280245AbRJaPy3>;
	Wed, 31 Oct 2001 10:54:29 -0500
Subject: Re: 2.4.14-pre6 + preempt dri lockup
From: Robert Love <rml@tech9.net>
To: safemode <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011031152822Z280263-17408+8294@vger.kernel.org>
In-Reply-To: <20011031152822Z280263-17408+8294@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 31 Oct 2001 10:55:05 -0500
Message-Id: <1004543705.1209.23.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-31 at 10:28, safemode wrote:
> Using 2.4.14-pre6 and Love's preempt patch, i recompiled my X's matrox drm 
> driver and loaded it.  All seemed well and good and i started X and it locked 
> up.  I had to reboot.  Upon rebooting I started X without loading the drm 
> module and disabling DRI and it loaded fine.  Tis not good.   The drm module 
> worked in every kernel prior to this one with and without the preempt patch.  
> I couldn't get an error message or anything but i did hear my monitor resync, 
> it just never displayed any kind of image.  The entire system was 
> unresponsive.

Did you try it in 2.4.14-pre6 w/o preempt patch?

Are you using the new non-atomic preempt patch (released last night for
pre5)?  If so, can you try an old version on pre6?  Apply the pre2
version to pre6 and see if it repeats...

	Robert Love

