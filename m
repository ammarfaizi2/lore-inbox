Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbTCJTEu>; Mon, 10 Mar 2003 14:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbTCJTEt>; Mon, 10 Mar 2003 14:04:49 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:24580 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S261412AbTCJTEs>;
	Mon, 10 Mar 2003 14:04:48 -0500
Date: Mon, 10 Mar 2003 20:13:15 +0100
From: "Sebastian 'yath' Schmidt" <yath@yath.eu.org>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_VT_CONSOLE and "console=ttyX" isn't working (bug?)
Message-Id: <20030310201315.396311e5.yath@yath.eu.org>
Reply-To: yath@yath.eu.org
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: @xfzn5Ctr)~Sl8fEE6ejyS,-R{-IW/@wzHTdVaB3]cNI3saCJ~6&4v7#V`sj64P(p'#GXaj1c>#SV{_7+OjlZi&^eF
 x5["@#pb}h6bI'|\"q@Y1bU8Dh-W!"k'%rozNZ1Z%J1HIrp??HCZLwR%<Dvz]0??5:*h|u>LsB[mew(OL#di'y*#[jB*.'ef8
 ov!_,rS)[|}%G4L|Hp#>6Z1$3`r)*C`Ciee6sD&</nN:W_<S5|z|JqM494N,Yo:~{!lHE_d()<**d!17GPLEn~ck!oTd),^hm
 ;r@P=Mok%-W+AS&`~@~YkLw[.G=taQTHv{"0Rx
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I wanted to use tty2 as boot console (where the printk() stuff goes to,
just to prevent misunderstandings), so I booted with "console=tty2".
Nevertheless, the printk() stuff is printed to tty1, though the output
of init goes correctly to tty2.

FYI, the first line I can see on tty1 is "Console: switching to color
frame buffer device...", the first line on tty2 is "INIT: Starting ...".

I dunno if I misunderstood something with CONFIG_VT_CONSOLE and/or
CONFIG_FB_* - maybe the latter breaks the first one?
(BTW, I found this bug(?) on 2.4.18 and 2.4.20, both vanilla)


Any suggestions?

Sebastian

