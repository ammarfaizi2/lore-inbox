Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280263AbRJaP2g>; Wed, 31 Oct 2001 10:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280266AbRJaP20>; Wed, 31 Oct 2001 10:28:26 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:3344 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S280263AbRJaP2U>; Wed, 31 Oct 2001 10:28:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14-pre6 + preempt dri lockup
Date: Wed, 31 Oct 2001 10:28:33 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011031152822Z280263-17408+8294@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.4.14-pre6 and Love's preempt patch, i recompiled my X's matrox drm 
driver and loaded it.  All seemed well and good and i started X and it locked 
up.  I had to reboot.  Upon rebooting I started X without loading the drm 
module and disabling DRI and it loaded fine.  Tis not good.   The drm module 
worked in every kernel prior to this one with and without the preempt patch.  
I couldn't get an error message or anything but i did hear my monitor resync, 
it just never displayed any kind of image.  The entire system was 
unresponsive.  
