Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUAFN2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 08:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUAFN2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 08:28:09 -0500
Received: from 154.69-93-101.reverse.theplanet.com ([69.93.101.154]:56450 "EHLO
	mail.clanhk.org") by vger.kernel.org with ESMTP id S262129AbUAFN2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 08:28:07 -0500
Message-ID: <1471.208.180.249.106.1073395438.squirrel@mail.clanhk.org>
In-Reply-To: <20040106135634.A5825@beton.cybernet.src>
References: <20040106135634.A5825@beton.cybernet.src>
Date: Tue, 6 Jan 2004 07:23:58 -0600 (CST)
Subject: Re: won't work: 2.6.0 && SiI 3112 SATA
From: "J. Ryan Earl" <heretic@clanhk.org>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello
>
> I try to make Adaptec SATA RAID AAR-1210SA (in fact, SiI 3112 ACT 144
> chip)
> work under 2.6.0
>
> When booting, get "hde: lost interrupt" and DMA errors. Tried to switch
> on/off local and I/O APIC (singleproc board) and the errors stay the same.
>
> Are these errors experienced on all SiI3112 boards? Are they experienced
> also in 2.4 kernel? Shall I try some "newer" kernel than 2.6.0?

Try the -mm sources for 2.6, or grab the files @
http://files.clanhk.org/siimage/ and put them under drivers/ide/pci/ and
recompile.  Please report your results.  I had the same problem, looked
into it, and changed something that fixed it for me.

-ryan
