Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbVLAUCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbVLAUCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbVLAUCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:02:37 -0500
Received: from ns2.suse.de ([195.135.220.15]:3242 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750725AbVLAUCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:02:37 -0500
Date: Thu, 1 Dec 2005 21:02:25 +0100
From: Andi Kleen <ak@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andi Kleen <ak@suse.de>, "Dugger, Donald D" <donald.d.dugger@intel.com>,
       linux-kernel@vger.kernel.org, "Shah, Rajesh" <rajesh.shah@intel.com>,
       akpm@osdl.org
Subject: Re: Add VT flag to cpuinfo; SSE3 flag
Message-ID: <20051201200225.GB997@wotan.suse.de>
References: <7F740D512C7C1046AB53446D372001730615842C@scsmsx402.amr.corp.intel.com> <Pine.LNX.4.61.0512011837470.28511@yvahk01.tjqt.qr> <20051201174901.GL19515@wotan.suse.de> <Pine.LNX.4.61.0512011901310.437@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512011901310.437@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I could not find pni either. This is all what cpuinfo gives on one:
> 
> processor       : 1
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 5
> model name      : AMD Opteron(tm) Processor 248
> stepping        : 10

Only E stepping or later Opterons have SSE3. Yours is older.

-Andi
