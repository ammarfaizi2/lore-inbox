Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261803AbTCGVvX>; Fri, 7 Mar 2003 16:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261804AbTCGVvX>; Fri, 7 Mar 2003 16:51:23 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:15307 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261803AbTCGVvW>; Fri, 7 Mar 2003 16:51:22 -0500
Message-ID: <3E69166F.9080604@nortelnetworks.com>
Date: Fri, 07 Mar 2003 17:00:15 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Chris Dukes <pakrat@www.uk.linux.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com> <1046990052.18158.121.camel@irongate.swansea.linux.org.uk> <20030306221136.GB26732@gtf.org> <20030306222546.K838@flint.arm.linux.org.uk> <1046996037.18158.142.camel@irongate.swansea.linux.org.uk> <20030306231905.M838@flint.arm.linux.org.uk> <1046996987.17718.144.camel@irongate.swansea.linux.org.uk> <20030307000816.P838@flint.arm.linux.org.uk> <20030307012905.G20725@parcelfarce.linux.theplanet.co.uk> <20030307094235.A11807@flint.arm.linux.org.uk> <20030307214749.GA20188@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Fri, Mar 07, 2003 at 09:42:35AM +0000, Russell King wrote:
> 
>>That's getting on for 2MB vs:
>>   2620    2012       0    4632    1218 fs/nfs/nfsroot.o
>>   8016     380      80    8476    211c net/ipv4/ipconfig.o
>>about 13K.
>>
> 
> There's a cap on the maximum size of things various bootloaders can
> load via tftp; 2MB is relatively certain to blow it. ISTR the limit
> being something near 1MB for 2 of my boxen.

Since this is totally machine/architecture specific (we're tftp'ing 10MB 
kernel/ramdisk images to embedded PPC machines here) it might be a good 
idea to ask around and find what the most restrictive requirements are. 
  Is 1MB the worst-case or does it get even tighter?

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

