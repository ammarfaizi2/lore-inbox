Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287519AbSAEFVS>; Sat, 5 Jan 2002 00:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287521AbSAEFVL>; Sat, 5 Jan 2002 00:21:11 -0500
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:49544
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S287519AbSAEFVA>; Sat, 5 Jan 2002 00:21:00 -0500
Message-ID: <00cc01c195a8$d7e4b960$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Manfred Spraul" <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <000701c19575$fed79ca0$010411ac@local>
Subject: Re: How to debug very strange packet delivery problem?
Date: Fri, 4 Jan 2002 22:21:35 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hadn't gone that far yet, no. Luckily at this time the machines are actually
located in the same office, so this shouldn't be too hard to do. Once the
problem machine is relocated to 30+ miles away, it would be a bit more
difficult :-)

----- Original Message -----
From: "Manfred Spraul" <manfred@colorfullife.com>
To: ""Kevin P. Fleming"" <kevin@labsysgrp.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, January 04, 2002 4:17 PM
Subject: Re: How to debug very strange packet delivery problem?


> > - watched the packets leave from the source machine with tcpdump on
> > the outbound interface, and the packets arrive intact at the problem
> > machine with tcpdump on the ppp interface
>
> Have you dumped the complete packet on both ends, and checked that it
> arrives really unchanged? (except the IP checksum and the ttl).
> IIRC the option should be -x -s 1500
>
> Perhaps some traffic shaper/firewall corrupts incomming SYN packets?
>
> --
>     Manfred
>
>
>
>

