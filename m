Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263273AbTCNHkA>; Fri, 14 Mar 2003 02:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbTCNHkA>; Fri, 14 Mar 2003 02:40:00 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:11167 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263273AbTCNHj5>; Fri, 14 Mar 2003 02:39:57 -0500
Message-ID: <001401c2e9fd$ee58a620$1900a8c0@ares>
From: adrian.golumbovici@t-online.de (Adrian Golumbovici)
To: <linux-kernel@vger.kernel.org>
Subject: [HELP] A7N8X (nforce2) and Radeon 9700 Pro ?!?
Date: Fri, 14 Mar 2003 08:47:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi mates,

I managed to solve my crash problem with the A7V8X and 1GB of mem by
changing it against a A7N8X :). Easiest sollution ever (but expensive tho
:) ). Anyway, my problem now is that I am sick of running my Radeon as Vesa.
Till now agpgart doesn't want to load on this board (nforce2 chipset) even
with agp_try_unsupported=1 and nvidia provides no driver for its agp beside
the nvagp module in the drivers for their graphics cards. Since I have an
ATI card I am not sure how to make it work in a better mode than vesa on my
mainboard. I read a lot of things on the net and I can shorten the long
story to the following:

1. Some suggesting to try to install the NVIDIA rpm and then use the nvagp
module with the ATI card. No answer from the original poster if it worked.:/
2. The current kernel agpgart module lacks the description for this card and
though some people offered to write the driver provided someone can help
with collecting the needed info, the post was left "in the air", so no news
there...
3. Some reported they managed to run their Radeon 9700 Pro as "pci" and not
"AGP" on this type of motherboard, but also no details provided upon how to
do that?!? PCI is a lot better than vesa anyway, but have no clue how to do
that. I also remember them stating that in order to do that you must compile
kernel without  dri support. Does that make it that you can load the Radeon
driver without having to use agpgart?!?
4. Some said that AGP is needed just to do some texture loading(?!? whatever
that is), but if the card has enough memory on the card (radeon 9700 Pro
comes with 128MB) you don't absolutely need it and that you can run it as
PCI (again?!? but again no clue how?!?) and works just fine (just a tad
slower than if ran in AGP on other motherboards where agpgart support
exists.

I am as clueless as a baby in a topless bar :) about how to get the best out
of my card under linux. I really want to try some gaming under linux, but
with vesa mode and Mesagl I can go smoke a cigar till next frame comes on
the screen.... Please help.

I am a programmer myself but never programmed for linux yet. I am willing to
help in development of agpgart for nforce2, but I need all the help I can
get. For starters, anyone know how I can find out the info about the agp on
this mobo (through reverse engineering probably, but dunno how)?

Best regards,
Adrian

