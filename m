Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318345AbSHUOQ4>; Wed, 21 Aug 2002 10:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318348AbSHUOQ4>; Wed, 21 Aug 2002 10:16:56 -0400
Received: from [143.166.83.88] ([143.166.83.88]:46863 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S318345AbSHUOQy>; Wed, 21 Aug 2002 10:16:54 -0400
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <20BF5713E14D5B48AA289F72BD372D6821CBA0@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: nagyt@otpbank.hu, linux-kernel@vger.kernel.org
Subject: RE: Problem determining number of CPUs
Date: Wed, 21 Aug 2002 09:20:55 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 117D7E42670764-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux kernel versions 2.4.18, 2.4.19, 2.4.20pre4 do not determine
> correctly the number of CPUs on our system. We see 8 CPUs 
> instead of 4,
> however the system works.
> 
> Our machine: Dell PowerEdge 6600, 4 Xeon 1400 Mhz, 4GB RAM

Yes, this is expected behavior due to hyperthreaded processors.
http://lists.us.dell.com/pipermail/linux-poweredge/2002-July/003465.html

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

