Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWARUOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWARUOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWARUOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:14:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:24483 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030409AbWARUOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:14:11 -0500
Date: Wed, 18 Jan 2006 21:14:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jean Delvare <khali@linux-fr.org>
cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: Linux 2.6.16-rc1
In-Reply-To: <20060118191247.62cc52cd.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.61.0601182112190.25325@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
 <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org>
 <20060118085936.4773dd77.khali@linux-fr.org> <20060118091543.GA8277@mars.ravnborg.org>
 <Pine.LNX.4.61.0601181421210.19392@yvahk01.tjqt.qr> <20060118191247.62cc52cd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>This ain't exactly the same command Sam had me test earlier today. This
>one breaks my /dev/null:
>
>  echo "main() {}" | gcc -xc - -o /dev/null

Right. It gets chmodded 777 here then.
I'd poke on gcc for that, or rather, ld (binutils).


Jan Engelhardt
-- 
