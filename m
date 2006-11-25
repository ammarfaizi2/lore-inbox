Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966881AbWKYRlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966881AbWKYRlY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 12:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966885AbWKYRlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 12:41:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966881AbWKYRlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 12:41:23 -0500
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
From: Arjan van de Ven <arjan@infradead.org>
To: Wink Saville <wink@saville.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <4568764B.7080505@saville.com>
References: <20061124170246.GA9956@elte.hu> <200611241813.13205.ak@suse.de>
	 <20061124202514.GA7608@elte.hu>  <4567B0CC.4030802@saville.com>
	 <1164443423.3147.51.camel@laptopd505.fenrus.org>
	 <4568764B.7080505@saville.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 25 Nov 2006 18:41:13 +0100
Message-Id: <1164476473.3147.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Actually, we need to ask the CPU/System makers to provide a system wide
> timer that is independent of the given CPU. I would expect it quite simple

they exist. They're called pmtimer and hpet.
pmtimer is port io. hpet is memory mapped io.




-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

