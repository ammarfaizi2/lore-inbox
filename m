Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315158AbSDWLLi>; Tue, 23 Apr 2002 07:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315159AbSDWLLh>; Tue, 23 Apr 2002 07:11:37 -0400
Received: from whiskey.openminds.be ([212.35.126.198]:12480 "EHLO
	whiskey.openminds.be") by vger.kernel.org with ESMTP
	id <S315158AbSDWLLg>; Tue, 23 Apr 2002 07:11:36 -0400
Date: Tue, 23 Apr 2002 13:11:10 +0200
From: Frank Louwers <frank@openminds.be>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
Message-ID: <20020423131110.A2009@openminds.be>
In-Reply-To: <20020423113935.A30329@openminds.be> <200204231102.g3NB2aX15231@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
X-PGP2: 1024R/1A899409  C3 D8 FA D3 E0 0E 40 C5  10 32 83 74 36 F0 E5 95
X-oldGPG: 1024D/3F6A7EDD  D597 566A BDF5 BBFB C308  447A 5E81 1188 3F6A 7EDD
X-GPG: 1024D/E592712F  E857 266C 04BE 0772 B9C4  E798 3D34 D5E5 E592 712F
Organisation: Openminds - http://www.openminds.be/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 02:05:02PM -0200, Denis Vlasenko wrote:
> On 23 April 2002 07:39, Frank Louwers wrote:
> > Is this a bug or a known issue? If it is not a bug, how can it be
> > solved?
> 
> Do you have ip forwarding enabled? If yes, kernel just forwards packets:
> network -> eth0 -> kernel
> 
> Try traceroute to eth1' ip. Examine arp tables. What MAC is listed there for 
> eth1 IP?

ipforwarding is disabled, arp proxy is disabled.

The mac address is that of eth0 ...

Vriendelijke groeten,
Frank Louwers

-- 
Openminds bvba                www.openminds.be
Tweebruggenstraat 16  -  9000 Gent  -  Belgium
