Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270467AbRHSOFu>; Sun, 19 Aug 2001 10:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270464AbRHSOFk>; Sun, 19 Aug 2001 10:05:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16398 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270466AbRHSOFd>; Sun, 19 Aug 2001 10:05:33 -0400
Subject: Re: Swap size for a machine with 2GB of memory
To: esr@thyrsus.com
Date: Sun, 19 Aug 2001 15:08:28 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List), gars@lanm-pc.com
In-Reply-To: <20010819024233.A26916@thyrsus.com> from "Eric S. Raymond" at Aug 19, 2001 02:42:33 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YTFc-0004DV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The screaming hotrod machine Gary Sandine and I built around the Tyan S2464
> has 2GB of physical memory.  Should I believe the above formula?  If not,

The formula is sort of true for 2.4 due to VM issues, its no longer true
for 2.4-ac because Rik fixed the weakness in question, and it wont matter
if you are not running >2Gb of toys anyway

Good that its no longer hung again - this is with noapic now ?
