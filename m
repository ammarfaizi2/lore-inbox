Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbUC3HjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUC3HjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:39:16 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:45980 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263334AbUC3HjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:39:13 -0500
Date: Mon, 29 Mar 2004 23:38:11 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, jun.nakajima@intel.com,
       ricklind@us.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       kernel@kolivas.org, rusty@rustcorp.com.au, anton@samba.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <207810000.1080632290@[10.10.2.4]>
In-Reply-To: <4069223E.9060609@yahoo.com.au>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>	<20040325154011.GB30175@wotan.suse.de>	<20040325190944.GB12383@elte.hu>	<20040325162121.5942df4f.ak@suse.de>	<20040325193913.GA14024@elte.hu>	<20040325203032.GA15663@elte.hu>	<20040329084531.GB29458@wotan.suse.de>	<4068066C.507@yahoo.com.au>	<20040329080150.4b8fd8ef.ak@suse.de>	<20040329114635.GA30093@elte.hu>	<20040329221434.4602e062.ak@suse.de>	<4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de> <40691BCE.2010302@yahoo.com.au> <205870000.1080630837@[10.10.2.4]> <4069223E.9060609@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well NUMA balance on exec is obviously the right thing to do.
> 
> Maybe balance on clone would be beneficial if we only balance onto
> CPUs which are idle or very very imbalanced. Basically, if you are
> very sure that it is going to be balanced off anyway, it is probably
> better to do it at clone.

Yup ... sounds utterly sensible. But I think we need to make the current
balance favour grouping threads together on the same CPU/node more first
if possible ;-)

M.

