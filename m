Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271032AbRH1Vzm>; Tue, 28 Aug 2001 17:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271142AbRH1Vzc>; Tue, 28 Aug 2001 17:55:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47376 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271032AbRH1VzQ>; Tue, 28 Aug 2001 17:55:16 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Treating parallel port as serial device
Date: 28 Aug 2001 14:55:04 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9mh3vo$q9m$1@cesium.transmeta.com>
In-Reply-To: <9mgtpb$mf4$1@sisko.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <9mgtpb$mf4$1@sisko.my.home>
By author:    "Tony Hoyle" <tmh@nothing-on.tv>
In newsgroup: linux.dev.kernel
>
> I'm looking to attach a serial device to my box that has only TTL level
> I/O.  Since I'm more of a software than a hardware person making a
> circuit board up with a max232 in is a bit risky...  I want to connect
> the I/O to the parallel port.
> 

Most RS232 boards accept TTL level input, so your only problem is
output.  You may want to simply construct a level converter, such as a
voltage divider or zener diode on your input.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
