Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbUKPRI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUKPRI6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUKPRI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:08:58 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:63369 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262051AbUKPRI4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:08:56 -0500
Date: Tue, 16 Nov 2004 18:05:27 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Stefan Schmidt <zaphodb@zaphods.net>, Nick Piggin <piggin@cyberone.com.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041116170527.GA3525@mail.muni.cz>
References: <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109224423.GC18366@mail.muni.cz> <20041109203348.GD8414@logos.cnet> <20041110212818.GC25410@mail.muni.cz> <20041110181148.GA12867@logos.cnet> <20041111214435.GB29112@mail.muni.cz> <4194A7F9.5080503@cyberone.com.au> <20041113144743.GL20754@zaphods.net> <20041116093311.GD11482@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041116093311.GD11482@logos.cnet>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 07:33:11AM -0200, Marcelo Tosatti wrote:
> > I took the default from 2.6.10-rc1-bk19 with your patch and doubled it. No
> > luck with the following values subsequently applied:
> > #vm.min_free_kbytes=3831
> > #vm.min_free_kbytes=7662
> > #vm.min_free_kbytes=15324
> > #vm.min_free_kbytes=61296
> > vm.min_free_kbytes=65535
> > Did not help against the page allocation errors or boosting up the machines
> > performance.
> 
> Nick, such high reservations should have protected the system from OOM.

> Definately. I suspect XFS is unable to handle OOM graciously, or some other
> problem.

It seems that both Stefan and me are using XFS. Does someone have this problems
with another filesystem? Unfortunately I cannot change fs. Can you Stefen?

-- 
Luká¹ Hejtmánek
