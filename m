Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTCHWNm>; Sat, 8 Mar 2003 17:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262260AbTCHWNm>; Sat, 8 Mar 2003 17:13:42 -0500
Received: from t2s5.tele2.cz ([213.246.64.40]:49572 "HELO t2s5.tele2.cz")
	by vger.kernel.org with SMTP id <S262258AbTCHWNl>;
	Sat, 8 Mar 2003 17:13:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: very buggy 3DFx framebuffer support!!! :(
Date: Sat, 8 Mar 2003 23:23:18 +0100
X-Mailer: KMail [version 1.3.2]
Cc: jsimmons@infradead.org, vandrove@vc.cvut.cz
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E18rmiu-0000ew-00@notas>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found out very buggy 3DFx framebuffer support :(

when I select nothing when console bootings, I got white background under 
Tux, rolling up with black background of text. Then everything under Tux has 
black background and white text, but there, where is tux icon everything on 
the right side of the icon has still white background

when I select in lilo 
append="video=tdfx:1024x768-24@75"

my console gets screws up and I can't see anything under it. X windows but 
works.

When I boot computer without append and then call it with fbset -a 
1024x768-75 things are the same ;( and I still can select Xwindows with alt+f7

Please can anybody fix this?

Linux 2.4.20 vanilla, gcc 3.0.4, Debian woody 3.0r1, 3DFx card, P3 733 
Coppermine

I don't get linux-kernel, so please if anybody will fix that, send me patches 
to test, coz some things were made in 2.4.19 and then thing goes worser then 
before. I wanna comunicate with developers to solve this, coz this bug is in 
kernel for a long time nonfixed :((

Michal
