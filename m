Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271813AbTHML1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271816AbTHML1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:27:54 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:5335 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S271813AbTHML1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:27:53 -0400
Date: Wed, 13 Aug 2003 13:27:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andrew Morton <akpm@osdl.org>
cc: Roland McGrath <roland@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] read_trylock for i386
In-Reply-To: <20030813020117.0acc5383.akpm@osdl.org>
Message-ID: <Pine.GSO.3.96.1030813131756.25530A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003, Andrew Morton wrote:

> So it would be better if someone could sweep all those together, implement
> the necessary stubs for uniprocessor builds on all architectures and
> apologetically break the build on the remaining SMP architectures.
> 
> That would appear to be mips, parisc, s390, sparc and x86_64.

 Well, the code for mips will be less complicated even.  I can supply it
if the i386 patch goes in.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

