Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280129AbRKEClX>; Sun, 4 Nov 2001 21:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280130AbRKEClN>; Sun, 4 Nov 2001 21:41:13 -0500
Received: from sushi.toad.net ([162.33.130.105]:44253 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S280129AbRKECk7>;
	Sun, 4 Nov 2001 21:40:59 -0500
Subject: Re: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
From: Thomas Hood <jdthood@mail.com>
To: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111050149580.27009-700000@druid.if.uj.edu.pl>
In-Reply-To: <Pine.LNX.4.33.0111050149580.27009-700000@druid.if.uj.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 04 Nov 2001 21:40:13 -0500
Message-Id: <1004928020.1319.73.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-11-04 at 20:18, Maciej Zenczykowski wrote:
> Well here you have it...
> 
> W98SE reports the FDC at 0x3f0..0x3f5 and 0x3f7

That's what the ThinkPad 600 technical reference
manual says about my machine too.

> all in all it is very weird and I do not know what to make of it...
> [ABIT SA6 motherboard with AWARD bios]

Well, if the floppy driver never accesses 0x3f0 or 0x3f1,
then it would seem that it should not reserved those
ioports.

--
Thomas

