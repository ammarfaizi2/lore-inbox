Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVFBQw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVFBQw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVFBQw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:52:56 -0400
Received: from main.gmane.org ([80.91.229.2]:54664 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261196AbVFBQwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:52:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: 2.6.12-rc5-git6 mis-counted ide interfaces
Date: Thu, 02 Jun 2005 18:49:35 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.02.16.49.34.279491@smurf.noris.de>
References: <429ECE20.1030403@ribosome.natur.cuni.cz> <20050602033253.77cd66d9.akpm@osdl.org> <429ED313.3080704@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Martin MOKREJŠ wrote:

> Andrew Morton wrote:
>> Martin MOKREJ__ <mmokrejs@ribosome.natur.cuni.cz> wrote:
>>>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>>>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
>>> Probing IDE interface ide0...
>>> hda: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
>>> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>>> Probing IDE interface ide1...
>>> ----------------------^^^^ ide0 I believe

Why?

>> Does the kernel boot and run OK, or does something actually go wrong?
> 
> It works fine, just the *extra* "Probing IDE interface ide1..." line made me
> worry about.

I fail to see the problem -- the kernel probes ide0 once, and ide1 once.
I'd assume that that is what's supposed to happen ..?

I't be more worried if it decided to check ide0 again.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I will not pick up a glowing ancient artifact and shout "Its power is
now mine!!!" Instead I will grab some tongs, transfer it to a hazardous
materials container, and transport it back to my lab for study.
		-- The Evil Overlord List


