Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSKTQT7>; Wed, 20 Nov 2002 11:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261365AbSKTQT6>; Wed, 20 Nov 2002 11:19:58 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:34434 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261356AbSKTQT5>; Wed, 20 Nov 2002 11:19:57 -0500
Subject: RE: [BUG?] Xeon with HyperThreading and linux-2.4.20-rc2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steffen Persvold <sp@scali.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211201657300.13800-100000@sp-laptop.isdn.scali.no>
References: <Pine.LNX.4.44.0211201657300.13800-100000@sp-laptop.isdn.scali.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 16:55:24 +0000
Message-Id: <1037811324.3241.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 16:00, Steffen Persvold wrote:
> On Wed, 20 Nov 2002, Nakajima, Jun wrote:
> 
> > As Hugh pointed out, the MPS table should report the physical processors
> > only even if HT is enabled. The major reason is to support legacy OSes that
> > don't support HT well. If the BIOS has an option for you to enable/disable
> > HT, then please use it. 
> 
> But since my BIOS reports 4 CPU's in the MPS table (with HT enabled), I 
> guess the BIOS is doing something wrong ? Should I report this to the 
> vendor ?

Im not sure about "wrong". Unusual perhaps. Nothing in the MPS spec
prohibits this that I can see

