Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbSKJF2e>; Sun, 10 Nov 2002 00:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSKJF2e>; Sun, 10 Nov 2002 00:28:34 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:14855
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264748AbSKJF2e>; Sun, 10 Nov 2002 00:28:34 -0500
Date: Sun, 10 Nov 2002 00:32:33 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
In-Reply-To: <200211091752.gA9HqR802867@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0211100031400.10475-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Nov 2002, J.E.J. Bottomley wrote:

> The CONFIG_X86_PIT was something I added to try to clarify.  There are three 
> cases with this:
> 
> PIT y, TSC n: Never use TSC, always use PIT
> PIT y, TSC y: Try TSC at first, if it doesn't work, fall back to PIT
> PIT n, TSC y: TSC always works, use it without testing.
> 
> Obviously PIT n, TSC n is bogus.

<n00b> How does one go about building a kernel with PIT y and TSC y ? My 
current kernels obviously are incapable of disabling the TSC </n00b>

	Zwane
-- 
function.linuxpower.ca

