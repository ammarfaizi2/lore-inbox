Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVBXThf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVBXThf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 14:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVBXThf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 14:37:35 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:39301
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262456AbVBXThb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 14:37:31 -0500
Date: Thu, 24 Feb 2005 11:33:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: nickpiggin@yahoo.com.au, ak@suse.de, benh@kernel.crashing.org,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
Message-Id: <20050224113350.3b6ebdd9.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0502241143001.6630@goblin.wat.veritas.com>
References: <4214A1EC.4070102@yahoo.com.au>
	<4214A437.8050900@yahoo.com.au>
	<20050217194336.GA8314@wotan.suse.de>
	<1108680578.5665.14.camel@gaston>
	<20050217230342.GA3115@wotan.suse.de>
	<20050217153031.011f873f.davem@davemloft.net>
	<20050217235719.GB31591@wotan.suse.de>
	<4218840D.6030203@yahoo.com.au>
	<Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>
	<421B0163.3050802@yahoo.com.au>
	<Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com>
	<421D1737.1050501@yahoo.com.au>
	<Pine.LNX.4.61.0502240457350.5427@goblin.wat.veritas.com>
	<1109224777.5177.33.camel@npiggin-nld.site>
	<Pine.LNX.4.61.0502241143001.6630@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005 11:58:42 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> Has anyone _ever_ seen a p??_ERROR message?

It triggers when you're writing new platform pagetable support
or making drastric changes in same.  But on sparc64 I've set
them all to nops to make the code output smaller. :-)
