Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUHMV0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUHMV0u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 17:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUHMV0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 17:26:50 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:15049 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S267588AbUHMV0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 17:26:08 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Ralf Gerbig <rge-news@hsp-law.de>
Subject: Re: rc4-mm1 pci-routing
Date: Fri, 13 Aug 2004 15:25:58 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Ralf Gerbig <rge-news@quengel.org>
References: <200408111642.59938.bjorn.helgaas@hp.com> <m0brheycgo.fsf@test3.hsp-law.de>
In-Reply-To: <m0brheycgo.fsf@test3.hsp-law.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408131525.58650.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 August 2004 3:06 pm, Ralf Gerbig wrote:
> The on the first boot of rc4-mm1 the last line on the screen was about
> starting ALSA, so I assumed that was what broke and sent the diff of 
> the 'boot.msg' (SuSE 9.1) with and without pci=routeirq.

So this was some unrelated problem, and the hang occurs both with
and without "pci=routeirq"?

> Then I compiled the intel8x0 driver into the kernel send the resulting
> boot.msg with pci=routeirq. Thereafter I hooked up a serial console and 
> found an oops from the 'wondershaper' and other unrelated breakage. 

And you think the wondershaper oops was also unrelated to "pci=routeirq"?
Having to reorder wondershaper to avoid an oops doesn't sound like an
optimal solution.

So, if you don't have any problems you can blame on my patch, great!
And don't feel sorry; my change exposed several driver bugs, so I'm
glad for every testing report!
