Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVLARk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVLARk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVLARk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:40:58 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:9609 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932342AbVLARk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:40:57 -0500
Date: Thu, 1 Dec 2005 18:40:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Dugger, Donald D" <donald.d.dugger@intel.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       "Shah, Rajesh" <rajesh.shah@intel.com>, akpm@osdl.org
Subject: RE: Add VT flag to cpuinfo; SSE3 flag
In-Reply-To: <7F740D512C7C1046AB53446D372001730615842C@scsmsx402.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.61.0512011837470.28511@yvahk01.tjqt.qr>
References: <7F740D512C7C1046AB53446D372001730615842C@scsmsx402.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>As I said, we discussed this internally and the concensus was that
>`vmx' was correct.  Especially since this term is used in the
>documentation this should be safe.

If not, I would propose to prefix or postfix the cpuflag somehow, maybe 
coupled with the arch or creator like 'ivmx' (intel vmx) and 'pvmx' (ppc 
vmx).

Oh BTW, I am missing an 'sse3' flag in /proc/cpuinfo on Opterons (running 
2.6.13). Could this be added, if it has not yet in 2.6.15rc*?


Jan Engelhardt
-- 
