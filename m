Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318470AbSHUR2c>; Wed, 21 Aug 2002 13:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSHUR2b>; Wed, 21 Aug 2002 13:28:31 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:36787 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S318470AbSHUR2b>; Wed, 21 Aug 2002 13:28:31 -0400
Date: Wed, 21 Aug 2002 18:33:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: James Bourne <jbourne@mtroyal.ab.ca>
cc: "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Hyperthreading
In-Reply-To: <Pine.LNX.4.44.0208210739220.8264-100000@skuld.mtroyal.ab.ca>
Message-ID: <Pine.LNX.4.44.0208211826180.10811-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002, James Bourne wrote:
> On Wed, 21 Aug 2002, Reed, Timothy A wrote:
> > 
> > Can anyone lead me to a good source of information on what options should be
> > in the kernel for hyperthreading??  I am still fighting with a
> > sub-contractor over kernel options.
> 
> As long as you have a P4 and use the P4 support you will get
> hyperthreading with 2.4.19 (CONFIG_MPENTIUM4=y).  2.4.18 you have to also 
> turn it on with a lilo option of acpismp=force on the kernel command line.

You do need CONFIG_SMP and a processor capable of HyperThreading,
i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
just appropriate to that processor in other ways.

Hugh

