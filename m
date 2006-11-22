Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162033AbWKVKma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162033AbWKVKma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162038AbWKVKma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:42:30 -0500
Received: from cantor2.suse.de ([195.135.220.15]:33959 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162031AbWKVKm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:42:29 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: 2.6.19-rc5: known regressions (v3)
Date: Wed, 22 Nov 2006 11:36:14 +0100
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, gregkh@suse.de,
       Ingo Molnar <mingo@redhat.com>, Len Brown <len.brown@intel.com>,
       phil.el@wanadoo.fr, oprofile-list@lists.sourceforge.net
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <200611151135.48306.dada1@cosmosbay.com> <200611221128.05769.dada1@cosmosbay.com>
In-Reply-To: <200611221128.05769.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611221136.14565.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 November 2006 11:28, Eric Dumazet wrote:
> On Wednesday 15 November 2006 11:35, Eric Dumazet wrote:
> > On Wednesday 15 November 2006 11:21, Adrian Bunk wrote:
> > > Subject    : x86_64: oprofile doesn't work
> > > References : http://lkml.org/lkml/2006/10/27/3
> > > Submitter  : Prakash Punnoor <prakash@punnoor.de>
> > > Status     : unknown
> >
> 
> I hit the same problem on i386 architecture too, if CONFIG_ACPI is not set.

oprofile is still broken because it cannot deal with the lack of perfctr 0.
You can disable the nmi watchdog as a workaround.

-Andi
