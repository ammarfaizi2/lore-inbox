Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTEGPdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbTEGPdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:33:20 -0400
Received: from vicar.dcs.qmul.ac.uk ([138.37.88.163]:41953 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP id S264069AbTEGPdT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:33:19 -0400
Date: Wed, 7 May 2003 16:45:48 +0100 (BST)
From: Matt Bernstein <mb--lkml@dcs.qmul.ac.uk>
To: Andi Kleen <ak@muc.de>
cc: Andrew Morton <akpm@digeo.com>, elenstev@mesatop.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
In-Reply-To: <20030507123508.GA6060@averell>
Message-ID: <Pine.LNX.4.55.0305071643150.1779@r2-pc.dcs.qmul.ac.uk>
References: <1051908541.2166.40.camel@spc9.esa.lanl.gov>
 <20030502140508.02d13449.akpm@digeo.com> <1051910420.2166.55.camel@spc9.esa.lanl.gov>
 <Pine.LNX.4.55.0305030014130.1304@jester.mews> <20030502164159.4434e5f1.akpm@digeo.com>
 <20030503025307.GB1541@averell> <Pine.LNX.4.55.0305030800140.1304@jester.mews>
 <Pine.LNX.4.55.0305061511020.3237@r2-pc.dcs.qmul.ac.uk> <20030506143533.GA22907@averell>
 <Pine.LNX.4.55.0305071121220.6697@r2-pc.dcs.qmul.ac.uk> <20030507123508.GA6060@averell>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean (19DR76-0003YC-Vl)
X-Auth-User: jonquil.thebachchoir.org.uk
X-uvscan-result: clean (19DR7A-0001G7-Dq)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:35 +0200 Andi Kleen wrote:

>It tries to patch an instruction past the kernel text.
>
>It could be in the discarded .exit.text/.text.exit. With new binutils you should
>get an link error when this happens, but perhaps yours are too old for that.

I'm using the RH 9 standard 2.13.90.0.18-9. My environment is exactly RH9
+ modutils 2.4.22-10 from rawhide, on a single Athlon XP.

>When you comment these entries out from the DISCARD statement in 
>arch/i386/vmlinux.lds.S does it go away ? Alternatively use Andrew's
>latest 2.5.69-mm*, that has the patch too.

Tried 2.5.69-mm2, it crashed the same way :-/
