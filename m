Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136235AbRDVRt1>; Sun, 22 Apr 2001 13:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136236AbRDVRtR>; Sun, 22 Apr 2001 13:49:17 -0400
Received: from huizehofstee.xs4all.nl ([194.109.241.183]:11024 "EHLO
	server.hofstee") by vger.kernel.org with ESMTP id <S136235AbRDVRtA>;
	Sun, 22 Apr 2001 13:49:00 -0400
Date: Sun, 22 Apr 2001 19:47:13 +0200
From: Victor Julien <v.p.p.julien@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.3+ sound distortion
Message-ID: <20010422194713.A321@victor>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>We are still playing with the VIA fixups, but this may also be VM related.
I'm
>currently playing with several VM ideas, and potential fixes which might
>impact overall performance.
>
>Test 2.4.4pre6 that has the VIA fixes but does not have the VM changes

2.4.4-pre6 did only compile when I aplied the '__builtin_expect'-patch. It
crashed at boot however, when initializing my onboard raidcontroller
(PDC20265 on a MSI K7T Turbo-R). It seems to be the same problem as
reported by Manuel A. McLure. So no word yet about the sound
distortion-problem being fixed.

Victor Julien

