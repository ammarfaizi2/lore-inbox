Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316901AbSE1UQm>; Tue, 28 May 2002 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316904AbSE1UQl>; Tue, 28 May 2002 16:16:41 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:33153 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S316901AbSE1UQl>; Tue, 28 May 2002 16:16:41 -0400
Date: Tue, 28 May 2002 22:18:51 +0200
Organization: Pleyades
To: abraham@2d3d.co.za, linux-kernel@vger.kernel.org
Subject: Re: Changing the current RTC device interface
Message-ID: <3CF3E62B.mail6AX1MQ2Z5@viadomus.com>
In-Reply-To: <20020528162435.A4917@crystal.2d3d.co.za>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Abraham :)

>>Any objections / suggestions / comments about things that's wrong/right
>>about the current RTC implementation?

    I think that, today at least, the nvram device is almost useless,
since only a few bytes are common to all BIOS vendors. The best
solution I can think about is just the same you propose: two devices,
one for the processor builtin RTC (the TSC counter?) and another for
the usual RTC on the motherboard.

    The only ugly thing I see is the NVRam driver, which I consider
useless these days.

    Raúl
