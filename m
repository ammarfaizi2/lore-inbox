Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317457AbSIELuF>; Thu, 5 Sep 2002 07:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSIELuF>; Thu, 5 Sep 2002 07:50:05 -0400
Received: from ns.suse.de ([213.95.15.193]:9993 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317457AbSIELuF>;
	Thu, 5 Sep 2002 07:50:05 -0400
Date: Thu, 5 Sep 2002 13:54:40 +0200
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>, Andi Kleen <ak@suse.de>,
       Harald Welte <laforge@gnumonks.org>,
       Netfilter Mailing List <netfilter-devel@lists.netfilter.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Schaaf <bof@bof.de>
Subject: Re: ip_conntrack_hash() problem
Message-ID: <20020905135440.A10805@wotan.suse.de>
References: <1031210342.9785.159.camel@biker.pdb.fsc.net> <20020905115208.4D0A02C064@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020905115208.4D0A02C064@lists.samba.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll feed this through 2.5, once it's had some more testing (hint
> hint!).  Then Harald will make a call on 2.4.

I would propose to include Martin's simple patch as a short term fix 
for 2.4 until Rusty's full work can get in. It fixes an bad performance
problems in some not too uncommon cases.

-Andi
