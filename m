Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318213AbSHDRBY>; Sun, 4 Aug 2002 13:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318214AbSHDRBX>; Sun, 4 Aug 2002 13:01:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:65272 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318213AbSHDRBX>; Sun, 4 Aug 2002 13:01:23 -0400
Subject: Re: 2.4.19 IDE Partition Check issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniela Engert <dani@ngrt.de>
Cc: "alien.ant@ntlworld.com" <alien.ant@ntlworld.com>,
       Alex Davis <alex14641@yahoo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200208041558.RAA32583@myway.myway.de>
References: <200208041558.RAA32583@myway.myway.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 19:23:14 +0100
Message-Id: <1028485394.14195.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 16:58, Daniela Engert wrote:
> ALi IDE controllers up to revision C4h don't support LBA48 in DMA mode,
> later revisions can do both PIO and DMA with LBA48 addressing. Check
> out ALi's Windows drivers to see how the manufacturer itself worked
> around this problem (it's kinda obvious).

Ok I've disabled LBA48 for revisions < 0xC4 lets see if that helps

