Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136107AbREIK2c>; Wed, 9 May 2001 06:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136078AbREIK2X>; Wed, 9 May 2001 06:28:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62728 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136045AbREIK2G>; Wed, 9 May 2001 06:28:06 -0400
Subject: Re: How to compile kernel for Geode GX1
To: antonpoon@hongkong.com
Date: Wed, 9 May 2001 11:32:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NU989490825851.03996@mail2.hongkong.com> from "antonpoon@hongkong.com" at May 09, 2001 05:41:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xRGL-00020g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How can I compile a kernel that would be running on a National Semicond=
> uctor Geode GX1 processor?

Geode aka Cyrix MediaGX is 586 without TSC. You'll want SB for the sound
drivers assuming the BIOS emulation set your board has actually works, and
you will want to pick up XFree86 3.3.6 and change the MediaGX code to the
stuff NatSemi provided I suspect. The patches for that are in the RH
XFree86 3.3.6 server srpm if you need them. 

It also needs non standard XF86Config modelines

Alan

