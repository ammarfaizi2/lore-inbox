Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbTEHGcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 02:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbTEHGcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 02:32:35 -0400
Received: from zero.aec.at ([193.170.194.10]:48644 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261181AbTEHGce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 02:32:34 -0400
Date: Thu, 8 May 2003 08:44:54 +0200
From: Andi Kleen <ak@muc.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: garbled oopsen
Message-ID: <20030508064454.GA21704@averell>
References: <m34r46dufb.fsf@averell.firstfloor.org> <23400000.1052364724@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23400000.1052364724@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 05:32:04AM +0200, Martin J. Bligh wrote:
> The trouble is that the subsystems you want may be broken (eg timers).

rdtsc/get_cycles() should still work. If that's broken too you have a really 
serious problem. It's only on the local CPU, so you don't need any complications
for bro^wunsynced SMP systems.

-Andi
