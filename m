Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265385AbTLHMGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 07:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265386AbTLHMGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 07:06:19 -0500
Received: from holomorphy.com ([199.26.172.102]:5851 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265385AbTLHMGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 07:06:18 -0500
Date: Mon, 8 Dec 2003 04:06:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC support on Slot-A Athlon, K6
Message-ID: <20031208120615.GF8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ryan Underwood <nemesis-lists@icequake.net>,
	linux-kernel@vger.kernel.org
References: <20031208102800.5409.87787.Mailman@lists.us.dell.com> <20031208115859.GA17909@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208115859.GA17909@dbz.icequake.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, someone wrote:
>> Furthermore, I/O-APIC usage requires (in hardware) that the
>> processor has a local APIC.

On Mon, Dec 08, 2003 at 05:58:59AM -0600, Ryan Underwood wrote:
> What can the APIC support alone accomplish, without an I/O-APIC?
> Just NMI watchdog and related things? (looking at CONFIG_APIC help)
> Looks like I/O-APIC is the real desired feature, but a functioning local
> APIC, though not very useful by itself, is a prerequisite for it.

LVT interrupts are likely still usable in such scenarios.


-- wli
