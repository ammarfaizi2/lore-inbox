Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269142AbUIBUwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269142AbUIBUwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269119AbUIBUwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:52:35 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:154
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269107AbUIBUva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:51:30 -0400
Date: Thu, 2 Sep 2004 13:50:23 -0700
From: "David S. Miller" <davem@davemloft.net>
To: lkml@einar-lueck.de
Cc: elueck@de.ibm.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
Message-Id: <20040902135023.1cacf608.davem@davemloft.net>
In-Reply-To: <200409021451.55318.elueck@de.ibm.com>
References: <200409021401.42255.elueck@de.ibm.com>
	<200409021420.46785.elueck@de.ibm.com>
	<1094124266.4970.20.camel@localhost.localdomain>
	<200409021451.55318.elueck@de.ibm.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004 14:51:55 +0200
Einar Lueck <elueck@de.ibm.com> wrote:

> On Donnerstag, 2. September 2004 13:24 Alan Cox wrote:
> > You've failed as far as I can see to explain why NAT doesn't do the
> > right thing in this case. I don't care whether the customers like it, I
> > care whether it works. If it works then we don't need to add junk to the
> > kernel. If it works but is hard to configure then its an opportunity to
> > write a nice tool to manage it.
> I am sorry: I failed to point out that NAT does the job!
> 
> We think that the the proposed patch, that is a really small one,
> introduces a facility that works well for existing operating systems 
> and is desired by customers. Consequently, it enriches the kernel with
> a concept that has already proven its value.

We never add patches that duplicate existing functionality just to
make it somehow "easier" for the user.  That's a job for scripts
and good tools, that make use of existing kernel facilities.

Alan is saying you can hide whatever complexity you claim exists via
tools, without any kernel modifications.  If you continue to ignore
that part of the discussion, it seems likely we will just the same
ignore your patch.

I, frankly, see no reason at all to even remotely consider your patch.
Furthermore, you'll get more discussion by bringing this up in the proper
place to propose such networking changes (netdev@oss.sgi.com).

