Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbULMLgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbULMLgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbULMLgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:36:05 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:53633 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262231AbULMLgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:36:03 -0500
Date: Mon, 13 Dec 2004 12:33:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hans Kristian Rosbach <hk@isphuset.no>
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       pavel@suse.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041213113330.GT16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org> <1102936790.17227.24.camel@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102936790.17227.24.camel@linux.local>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 12:19:50PM +0100, Hans Kristian Rosbach wrote:
> Is there any recommended lower bound setting?
> Would there be a point in recommending lower settings for desktops
> running only text consoles opposed to X desktops?

I don't know the ACPI details, but as far as dyanmic-hz is concerned I
seem to recall I tested it with HZ=10/25/50/... too (as well as
HZ=2000/5000...), everything will work flawlessy but any number below
<50 will pretty much guarantee not to show even an animated flash or gif
fluenty ;). Said that you can use X just fine, not only the console (my
X usage on the laptop sure doesn't need a fast HZ for example).
