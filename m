Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267845AbTAHSoL>; Wed, 8 Jan 2003 13:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267848AbTAHSoK>; Wed, 8 Jan 2003 13:44:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36626 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267845AbTAHSoI>; Wed, 8 Jan 2003 13:44:08 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PCI code:  why need  outb (0x01, 0xCFB); ?
Date: 8 Jan 2003 10:52:30 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <avhs1e$qmf$1@cesium.transmeta.com>
References: <F87sTOHYNhMwqvbLaKL0001615a@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <F87sTOHYNhMwqvbLaKL0001615a@hotmail.com>
By author:    "fretre lewis" <fretre3618@hotmail.com>
In newsgroup: linux.dev.kernel

> 1. which device is at port address 0xCFB?

Hopefully none.

> 2. what is meaning of the writing operation "outb (0x01, 0xCFB);" for THIS
> device?, it'seem that PCI spec v2.0 not say anything about it?

It's trying to verify that the PCI northbridge does *NOT* respond to
this (byte-wide) reference.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
