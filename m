Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280705AbRKJUL4>; Sat, 10 Nov 2001 15:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280707AbRKJULg>; Sat, 10 Nov 2001 15:11:36 -0500
Received: from pD952A7A1.dip.t-dialin.net ([217.82.167.161]:10369 "EHLO
	darkside.ddts.net") by vger.kernel.org with ESMTP
	id <S280705AbRKJUL3>; Sat, 10 Nov 2001 15:11:29 -0500
Date: Sat, 10 Nov 2001 20:26:52 +0100
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: linux-kernel@vger.kernel.org
Subject: isdn: isdnloop support crashes kernel when compiled in
Message-ID: <20011110202652.B14401@darkside.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi,

The isdnloop support for the ISDN subsystem crashes the kernel when
compiled in the kernel directly (null pointer reference).
I guess, this is because parameters are only given as MODULE_PARM().

I found that in the 2.4.12 kernel, if it's fixed already in higher
kernels, please excuse me :)

If this is a feature and not a bug, should'nt it then be forced
to be configured as a module in the Config.in?


PS: I'm not member on the linux-kernel@ list, so please CC me in
    replies, thanks.


regards,
   Mario
-- 
*axiom* welcher sensorische input bewirkte die output-aktion,
        den irc-chatter mit dem nick "dus" des irc-servers
        mittels eines kills zu verweisen?
