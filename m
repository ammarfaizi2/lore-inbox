Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUDHAWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 20:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUDHAWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 20:22:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33740
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261405AbUDHAWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 20:22:42 -0400
Date: Thu, 8 Apr 2004 02:22:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, mbligh@aracnet.com, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-ID: <20040408002240.GY26888@dualathlon.random>
References: <1081373058.9061.16.camel@arrakis> <20040407145130.4b1bdf3e.akpm@osdl.org> <5840000.1081377504@flay> <20040408003809.01fc979e.ak@suse.de> <20040407155225.14936e8a.akpm@osdl.org> <20040408013522.294f0322.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040408013522.294f0322.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 01:35:22AM +0200, Andi Kleen wrote:
> NUMA API adds a new pointer, but all sharing in the world couldn't fix that.

that's fine. As we already discussed from my part I only care that the
4bytes for the pointer go away if you compile with CONFIG_NUMA=n, it
doesn't really matter much but it'd like if it would be optimized for
the long term.
