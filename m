Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSJQA46>; Wed, 16 Oct 2002 20:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSJQA45>; Wed, 16 Oct 2002 20:56:57 -0400
Received: from ausadmmsps305.aus.amer.dell.com ([143.166.224.100]:38409 "HELO
	AUSADMMSPS305.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S261599AbSJQA44>; Wed, 16 Oct 2002 20:56:56 -0400
X-Server-Uuid: bc938b4d-8e35-4c08-ac42-ea3e606f44ee
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1E9EC@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: driver@jpl.nasa.gov, root@chaos.analogic.com
cc: mcuss@cdlsystems.com, linux-kernel@vger.kernel.org
Subject: RE: Kernel reports 4 CPUS instead of 2...
Date: Wed, 16 Oct 2002 20:02:42 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11B0D3B82704632-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My /proc/cpuinfo says I have ht CPU's... but i only see 2 
> CPU's... (Yet 
> I have 2 1.7Ghz XEONs in the box so shouldn't I see 4?)

1.8GHz Xeon and above have HyperThreading implemented.  Below that
processors may show the 'ht' bit in /proc/cpuinfo, but don't actually have
HT implemented on the chip.  There's a secondary call you have to make to
get the count of actual logical processors implemented - the 'ht' bit means
that the architecture is ht-capable. :-)

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

