Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262517AbRE0WZy>; Sun, 27 May 2001 18:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262514AbRE0WZo>; Sun, 27 May 2001 18:25:44 -0400
Received: from mail-out.chello.nl ([213.46.240.7]:22625 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S262522AbRE0WZ3>; Sun, 27 May 2001 18:25:29 -0400
From: Ben Twijnstra <b.twijnstra@chello.nl>
To: Chris Rankin <rankinc@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: Hard lockup switching to X from vc; Matrox G400 AGP
Date: Mon, 28 May 2001 0:24:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20010527221819.OANY3174.amsmta01-svc@[192.168.2.3]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Seen the same behaviour; you're not alone. I'm running XF86 4.0.3 with a G400. My guess is that mga_drv goes into some local loop while trying to restore the display. mga_drv at that moment has I/O privileges and if it hangs, Linux hangs too.

Grtz,


Ben


