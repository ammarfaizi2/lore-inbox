Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129382AbRBNVB1>; Wed, 14 Feb 2001 16:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129570AbRBNVBR>; Wed, 14 Feb 2001 16:01:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13326 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129382AbRBNVBM>; Wed, 14 Feb 2001 16:01:12 -0500
Message-ID: <3A8AF203.864461CD@transmeta.com>
Date: Wed, 14 Feb 2001 13:00:51 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ECN for servers ?
In-Reply-To: <Pine.LNX.3.96.1010214145253.30758C-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> On 14 Feb 2001, H. Peter Anvin wrote:
> > By author:    Petru Paler <ppetru@ppetru.net>
> > > What is the impact of enabling ECN on the server side ? I mean, will
> > > any clients (with broken firewalls) be affected if a SMTP/HTTP server
> > > has ECN enabled ?
> 
> > Pro: better behaviour in presence of network congestion.
> >
> > Con: people behind broken firewalls can't connect.
> 
> Since you can use ICMP to tunnel data, a lot of security ppl are
> reluctant to stop filtering ICMP :/
> 

You can use DNS to tunnel data, too.  As far as ICMP is concerned,
perhaps they should consider sterilizing approaches instead.

	-hp

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
