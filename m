Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262563AbTCRUVn>; Tue, 18 Mar 2003 15:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262567AbTCRUVn>; Tue, 18 Mar 2003 15:21:43 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:47310 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S262563AbTCRUVm>; Tue, 18 Mar 2003 15:21:42 -0500
Date: Tue, 18 Mar 2003 21:32:37 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: 2.5 strange lockups
Message-ID: <Pine.LNX.4.51.0303182126300.23967@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

under 2.5.65 on an uniprocesor p4 1.5ghz with 128mb ram with xfree4.2.x
with debian testing/unstable while updating and configuring packages
(what dselect does) the load increases enormously, the scenario is as
follows:
1. [dselect] unpacking replacement <some package>
2. mouseclicks on an x-terminal get sluggish
3. xmms stops playing
4. i am still able to click on _some_ of the open x-terminals, they
respond normally
5. the x-terminals freeze, after a few seconds the mouse freezes
6. the computer is frozen, the keyboard leds do not blink on pressing
numlock etc
7. After about 6-8 seconds everything comes back to normal

The load ('w' command) goes up to 4.

I was doing totally the same with 2.4.20, with no problems at all.

Regards,
Maciej Soltysiak
