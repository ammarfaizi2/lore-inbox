Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293650AbSCPB1h>; Fri, 15 Mar 2002 20:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293648AbSCPB12>; Fri, 15 Mar 2002 20:27:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14340 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293654AbSCPB1V>; Fri, 15 Mar 2002 20:27:21 -0500
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
To: davids@webmaster.com (David Schwartz)
Date: Sat, 16 Mar 2002 01:43:05 +0000 (GMT)
Cc: davem@redhat.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20020316000629.AAA989@shell.webmaster.com@whenever> from "David Schwartz" at Mar 15, 2002 04:06:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16m3Dt-0005Hr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Another solution could involve a netfilter module to mangle
> >the packets.
> 
> 	The problem is that this is intended to be used on machines that are routing 
> very high volumes of packets on multiple FEs. So the implementation would 

Dave's suggestion is netfilter - and netfilter is fast enough I think. You
only need filters on stuff you have already decided is for your IP too.
