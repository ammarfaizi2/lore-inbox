Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTLEQix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 11:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTLEQix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 11:38:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16908 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264259AbTLEQim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 11:38:42 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: A call for boot loader IDs
Date: 5 Dec 2003 08:38:13 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bqqc9l$qo6$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

So far only a small number of boot loaders have actually officially
registered their IDs, this is the list that I have:

  type_of_loader: 
        If your boot loader has an assigned id (see table below),
        enter 0xTV here, where T is an identifier for the boot loader
        and V is a version number.  Otherwise, enter 0xFF here.

        Assigned boot loader ids:
        0  LILO
        1  Loadlin
        2  bootsect-loader
        3  SYSLINUX
        4  EtherBoot
        5  ELILO

        Please contact <hpa@zytor.com> if you need a bootloader ID
        value assigned.

I would really appreciate if other boot loaders -- especially GRUB,
which is widely used -- would let me know (a) what they are currently
doing, and (b) whether or not they need an official allocation.  It's
probably unwise to not do so, at least for the ones which have a
significant user community.

The purpose of this ID is so we can work around individual boot loader
issues if we should have a need to adjust or change the boot
protocol.  Not reporting a unique ID makes this impossible.

	 -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
