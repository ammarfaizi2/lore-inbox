Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTEXVxs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTEXVxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 17:53:48 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:7553
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261179AbTEXVxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 17:53:47 -0400
Date: Sat, 24 May 2003 17:54:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Keith Owens <kaos@ocs.com.au>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "" <mort@wildopensource.com>, "" <davidm@napali.hpl.hp.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, "" <tomita@cinet.co.jp>
Subject: Re: cpu-2.5.69-bk14-1
In-Reply-To: <20030520170331.GK29926@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0305241750570.16144-100000@montezuma.mastecende.com>
References: <20030520170331.GK29926@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 May 2003, William Lee Irwin III wrote:

> Extended cpumasks for larger systems. Now featuring bigsmp, Summit,
> and Voyager updates in addition to PC-compatible, NUMA-Q, and SN2
> bits from SGI.
> 
> Several minor bugfixes with improper checks of bits and some new
> API pieces: cpumask_of_cpu() and cpus_promote() for replacing
> 1 << cpu and promoting "narrow" cpumasks (i.e. unsigned long) to
> full-width, respectively.
> 
> Successfully runs on 32x NUMA-Q. Successfully compiletested on Voyager,
> Summit, bigsmp, and flat logical SMP, all with typechecking. UP also
> successfully compiletested with and without local APIC and IO-APIC.
> Hopefully I can get my hands on another NUMA-Q quad or two soon.

Successfully run for 4 days with various stress loads. on normally 
troublesome 3way P133 with CONFIG_NR_CPUS = 72 (255 causes a #SS with 
large .configs/kernels)

	Zwane
-- 
function.linuxpower.ca
