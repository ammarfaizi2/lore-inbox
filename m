Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbUDUPKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUDUPKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 11:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUDUPKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 11:10:47 -0400
Received: from [217.73.129.129] ([217.73.129.129]:43395 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263173AbUDUPKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 11:10:45 -0400
Date: Wed, 21 Apr 2004 18:10:16 +0300
Message-Id: <200404211510.i3LFAGe7031761@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: two lockups with 2.4.25
To: cbs@cts.ucla.edu, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0404201554590.4433@potato.cts.ucla.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Stromsoe <cbs@cts.ucla.edu> wrote:
CS> Pid: 26885, comm:               sophie
>>>EIP; c0110ed7 <flush_tlb_others+9b/bc>   <=====
>>>EDX; 01000000 Before first symbol
>>>ESI; f4762cc0 <_end+343c85cc/3896e90c>
>>>EDI; 081a1d28 Before first symbol
>>>EBP; e806fe94 <_end+27cd57a0/3896e90c>
CS> Trace; c011100f <flush_tlb_page+6f/7c>
CS> Trace; c01259b7 <do_wp_page+223/284>
CS> Trace; c01260de <handle_mm_fault+82/b8>
CS> Trace; c01132f9 <do_page_fault+1a1/4ed>
CS> Trace; c0113158 <do_page_fault+0/4ed>
CS> Trace; c0224ce1 <__kfree_skb+129/134>
CS> Trace; c01145e3 <schedule+45b/520>
CS> Trace; c0106fc4 <error_code+34/3c>

This backtrace is suspiciously similar to a backtrace from NMI WD I had not so
long ago. Also on 2.5.25
Are your boxes SMP?

Bye,
    Oleg
