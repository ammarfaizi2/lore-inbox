Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVHUU5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVHUU5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 16:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbVHUU5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 16:57:39 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:58823 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750934AbVHUU5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 16:57:38 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Andi Kleen <ak@suse.de>
Cc: Howard Chu <hyc@symas.com>, linux-kernel@vger.kernel.org
Subject: Re: sched_yield() makes OpenLDAP slow
References: <43057641.70700@symas.com.suse.lists.linux.kernel>
	<17157.45712.877795.437505@gargle.gargle.HOWL.suse.lists.linux.kernel>
	<430666DB.70802@symas.com.suse.lists.linux.kernel>
	<p73oe7syb1h.fsf@verdi.suse.de>
Date: Sun, 21 Aug 2005 21:47:51 +0200
In-Reply-To: <p73oe7syb1h.fsf@verdi.suse.de> (Andi Kleen's message of "20 Aug
	2005 15:48:10 +0200")
Message-ID: <87fyt3vzq0.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen:

> Has anybody contacted the Sleepycat people with a description of the 
> problem yet?

Berkeley DB does not call sched_yield, but OpenLDAP does in some
wrapper code around the Berkeley DB backend.
