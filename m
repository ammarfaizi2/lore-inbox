Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270695AbTGUU25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270702AbTGUU2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:28:45 -0400
Received: from mail.gmx.de ([213.165.64.20]:18369 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270695AbTGUU2i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:28:38 -0400
From: Michael Schierl <schierlm-usenet@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 and LILO problem: "Device 0x0300: Invalid partition table, 1st entry"
Date: Mon, 21 Jul 2003 22:43:11 +0200
Reply-To: schierlm@gmx.de
References: <bwg3.CK.7@gated-at.bofh.it> <bx2m.19k.7@gated-at.bofh.it>
In-Reply-To: <bx2m.19k.7@gated-at.bofh.it>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-Id: <S270695AbTGUU2i/20030721202838Z+1474@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003 02:50:06 +0200, in linux.kernel you wrote:
>On Mon, Jul 21, 2003 at 01:57:53AM +0200, Michael Schierl wrote:
>
>> LILO version 22.2, Copyright (C) 1992-1998 Werner Almesberger
>> Development beyond version 21 Copyright (C) 1999-2001 John Coffman
>> Released 05-Feb-2002 and compiled at 20:57:26 on Apr 13 2002.
>...
>> Boot other: /dev/hda1, on /dev/hda, loader /boot/chain.b
>> Device 0x0300: Invalid partition table, 1st entry
>>   3D address:     1/1/261 (263151)
>>   Linear address: 1/12/4159 (4193028)
>
>I think the easiest answer is: get a more recent LILO.

Thanks. That helped.

>(And make sure to use linear or lba32 or so.)

lba32 was active before as well.

Michael
-- 
"New" PGP Key! User ID: Michael Schierl <schierlm@gmx.de>
Key ID: 0x58B48CDD    Size: 2048    Created: 26.03.2002
Fingerprint:  68CE B807 E315 D14B  7461 5539 C90F 7CC8
http://home.arcor.de/mschierlm/mschierlm.asc
