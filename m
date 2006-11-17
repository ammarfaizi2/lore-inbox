Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWKQPGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWKQPGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932924AbWKQPGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:06:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22930 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932068AbWKQPGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:06:39 -0500
Subject: Re: [PATCH][kprobe] enabling booster on the preemptible kernel
From: Ingo Molnar <mingo@redhat.com>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       "bibo,mao" <bibo.mao@intel.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       SystemTAP <systemtap@sources.redhat.com>,
       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
       Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>
In-Reply-To: <455DAC83.3030505@hitachi.com>
References: <455DAC83.3030505@hitachi.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 16:04:03 +0100
Message-Id: <1163775843.8789.55.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 21:35 +0900, Masami Hiramatsu wrote:
> From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> 
> This patch enables the kprobe-booster on the preemptible kernel.
> For this purpose, I introduced a kind of garbage collector of
> the instruction slots. This garbage collector checks safety before
> releasing the garbage slots.
> 
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> 

nice work - looks really sensible! This opens the door to djprobes (or
rather, to the transparent kprobes speedup that used to be a separate
interface), right?

 Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo

