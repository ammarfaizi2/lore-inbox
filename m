Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbUJ0IbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbUJ0IbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbUJ0IbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:31:01 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:63498 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S262320AbUJ0Ia4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:30:56 -0400
To: linux-kernel@vger.kernel.org
Cc: david@gibson.dropbear.id.au, Andrew Morton <akpm@osdl.org>
Subject: Re: MAP_SHARED bizarrely slow
From: James Cloos <cloos@jhcloos.com>
In-Reply-To: <20041027010659.15ec7e90.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 27 Oct 2004 01:06:59 -0700")
References: <20041027064527.GJ1676@zax>
	<m3u0sgiq0b.fsf@lugabout.cloos.reno.nv.us>
	<20041027010659.15ec7e90.akpm@osdl.org>
X-Hashcash: 0:041027:linux-kernel@vger.kernel.org:fa444bdbf344a379
X-Hashcash: 0:041027:david@gibson.dropbear.id.au:9d26422dbb5e3052
X-Hashcash: 0:041027:akpm@osdl.org:eaf128b3f3c437d0
Date: Wed, 27 Oct 2004 01:30:10 -0700
Message-ID: <m3lldsimwd.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

JimC> Both took about 11 seconds for the private and around 30 seconds
JimC> for the shared tests.

Andrew> I get the exact opposite, on a P4:

Interesting.  I gave it a try on a couple of my UMLs.  One is on a P4
(possibly xeon; not sure) and the other is on an athlon.  The p4 did
shared about twice as fast as private and the athlon was 50% faster.
(p4 uses uml kernel 2.4.27; athlon 2.6.6; no idea what the hosts run.)

-JimC
