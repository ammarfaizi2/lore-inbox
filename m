Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbTEFWXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbTEFWXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:23:47 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:19877 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262014AbTEFWXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:23:46 -0400
Date: Tue, 6 May 2003 23:35:43 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.69 oops at sysenter_past_esp
Message-ID: <20030506223534.GA3339@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, mikpe@csd.uu.se,
	linux-kernel@vger.kernel.org
References: <16056.4728.649612.413159@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16056.4728.649612.413159@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 09:52:24PM +0200, mikpe@csd.uu.se wrote:
 > suspending the box (apm). At resume, I am immediately greeted with an
 > oops looking like:
 > 
 > general protection fault: 0000 [#?]
 > CPU:	0
 > EIP:	0060:[<c0109079>]	Not tainted
 > EFLAGS:	00010246
 > EIP is at systenter_past_esp+0x6e/0x71

I wonder if your BIOS is trashing the sysenter MSRs on suspend.
Maybe they need restoring ?

		Dave

