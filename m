Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbTAORCD>; Wed, 15 Jan 2003 12:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbTAORCD>; Wed, 15 Jan 2003 12:02:03 -0500
Received: from [66.70.28.20] ([66.70.28.20]:49925 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266810AbTAORCB>; Wed, 15 Jan 2003 12:02:01 -0500
Date: Wed, 15 Jan 2003 17:57:53 +0100
From: DervishD <raul@pleyades.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Mark Mielke <mark@mark.mielke.cc>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030115165753.GE86@DervishD>
References: <20030114212113.GF15412@mark.mielke.cc> <Pine.LNX.3.95.1030115113606.18233A-200000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.3.95.1030115113606.18233A-200000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Richard :)

> Well, I just can't give this up!

    It's an interesting issue ;)))

> If you don't like me pretending that main() gets the environment
> after args[], you can access environ directly anyway with the
> same result. Have fun!

    Anyway, I'm not sure that all argv members are contiguous. I
mean, you can have argv[0] at 0x0c123456, length 3, and argv[1] not
at 0x0c123459, but at 0xdeadbeaf. I know, this is VERY improbable,
but argv is just an array of strings :((

    Anyway this code is brilliant ;)) Nice solution :)
    Raúl
