Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUJAWiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUJAWiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUJAWfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:35:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13455 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266687AbUJAWcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 18:32:18 -0400
Date: Fri, 1 Oct 2004 15:30:42 -0700
From: "David S. Miller" <davem@redhat.com>
To: Harald Welte <laforge@netfilter.org>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       samel@mail.cz
Subject: Re: [BUG] active ftp doesn't work since 2.6.9-rc1
Message-Id: <20041001153042.15ed4a82.davem@redhat.com>
In-Reply-To: <20041001141050.GH27499@sunbeam.de.gnumonks.org>
References: <20041001111201.GA23033@pc11.op.pod.cz>
	<20041001132248.GG27499@sunbeam.de.gnumonks.org>
	<20041001141050.GH27499@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004 16:10:50 +0200
Harald Welte <laforge@netfilter.org> wrote:

> On Fri, Oct 01, 2004 at 03:22:48PM +0200, Harald Welte wrote:
> > On Fri, Oct 01, 2004 at 01:12:01PM +0200, Vitezslav Samel wrote:
> > > 	Hi!
> > > 
> > >   After upgrade to 2.6.9-rc3 on the firewall (with NAT), active ftp stopped
> > > working. The first kernel, which doesn't work is 2.6.9-rc1.
> > > Sympotms: passive ftp works O.K., active FTP doesn't open data
> > > stream (and in logs there entries about invalid packets - using
> > > iptables ... -m state --state INVALID -j LOG)
> 
> Please use the following (attached) fix:
> 
> DaveM: Please apply and push to Linus:

Will do, thanks Harald.
