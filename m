Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285498AbSADXSE>; Fri, 4 Jan 2002 18:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285704AbSADXRo>; Fri, 4 Jan 2002 18:17:44 -0500
Received: from colorfullife.com ([216.156.138.34]:48906 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S285498AbSADXRc>;
	Fri, 4 Jan 2002 18:17:32 -0500
Message-ID: <000701c19575$fed79ca0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "\"Kevin P. Fleming\"" <kevin@labsysgrp.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: How to debug very strange packet delivery problem?
Date: Sat, 5 Jan 2002 00:17:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - watched the packets leave from the source machine with tcpdump on
> the outbound interface, and the packets arrive intact at the problem
> machine with tcpdump on the ppp interface

Have you dumped the complete packet on both ends, and checked that it
arrives really unchanged? (except the IP checksum and the ttl).
IIRC the option should be -x -s 1500

Perhaps some traffic shaper/firewall corrupts incomming SYN packets?

--
    Manfred

