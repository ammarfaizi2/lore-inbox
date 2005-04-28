Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVD1GuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVD1GuM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 02:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVD1GuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 02:50:12 -0400
Received: from smtp05.web.de ([217.72.192.209]:25261 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S261782AbVD1GuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 02:50:02 -0400
From: Gregor Jasny <gjasny@web.de>
To: LKML LIST <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
       stable@kernel.org
Subject: Re: [00/07] -stable review
Date: Thu, 28 Apr 2005 08:49:53 +0200
User-Agent: KMail/1.8
References: <20050427171446.GA3195@kroah.com>
In-Reply-To: <20050427171446.GA3195@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504280849.53777.gjasny@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, hi Takashi,

I would suggest these two patches for inclusion into the stable tree. They 
both fix a keyboard lockup when unplugging USB audio hardware.

With the first one applied I can plug / unplug my webcam without losing my 
keyboard. I couldn't test the second one, but both patches are in ALSA CVS.

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/usb/usbaudio.c?r1=1.119&r2=1.120
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/usb/usx2y/usbusx2y.c?r1=1.9&r2=1.10

Cheers,
Gregor
