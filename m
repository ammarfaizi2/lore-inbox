Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbSI0SO1>; Fri, 27 Sep 2002 14:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbSI0SO1>; Fri, 27 Sep 2002 14:14:27 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:49930 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262568AbSI0SO1>; Fri, 27 Sep 2002 14:14:27 -0400
Date: Fri, 27 Sep 2002 19:19:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020927191943.A2204@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20020927003210.A2476@sgi.com> <Pine.GSO.4.33.0209270743170.22771-100000@raven> <20020927175510.B32207@infradead.org> <200209271809.g8RI92e6002126@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209271809.g8RI92e6002126@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Fri, Sep 27, 2002 at 02:09:02PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 02:09:02PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 27 Sep 2002 17:55:10 BST, Christoph Hellwig said:
> 
> > And WTF is the use a security policy that checks module arguments?  Do
> > you want to disallow options that are quotes from books on the index
> > or not political correct enough for a US state agency?
> 
> How about a security policy that says:
> 
> 1) Thou mayest do an 'modprobe wvlan_cs'
> 
> 2) Thou mayest not do 'modprobe wvlan_cs eth=0'.
> 
> 'eth=0' causes it to create the interface as 'wvlan0' 'wvlan1' etc rather
> than 'eth0', 'eth1', etc.  This makes a difference if you have iptables
> rules that say '-i eth+' or '-i wvlan+' that implement different rulesets
> for wireless and hard-wired connections.

So I have to download the driver source and change the parameter
to i_m_to_fscking_intelligent_for_the_nsa_eth=0?
