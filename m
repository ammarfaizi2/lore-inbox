Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbTIGVB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbTIGVB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:01:28 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:31710 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261408AbTIGVB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:01:26 -0400
Date: Sun, 7 Sep 2003 22:59:51 +0200 (MEST)
From: peter_daum@t-online.de (Peter Daum)
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT
In-Reply-To: <20030907195557.GK14436@fs.tum.de>
Message-ID: <Pine.LNX.4.30.0309072228110.9987-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Seen: false
X-ID: V8lg8BZbZemXZeI-37ibuqaWE3tZNkNB7Wf1dVkUVVGEMkHx4n4F4x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 7 Sep 2003, Adrian Bunk wrote:

> Peter Daum reported in the "2.4.22 with CONFIG_M686: networking broken"
> thread some problems when using a kernel with CONFIG_M686 on a
> Pentium 4.

... actually, the problems also occurred when running on machines
with Pentium II/Pentium Pro CPUs - even on these machines, I only
could use kernels compiled with "CONFIG_MPENTIUM4".

Adrian's patch does fix these problems. What is amazing, is that
in kernel version 2.4.20, the same values were used for
"CONFIG_X86_L1_CACHE_SHIFT". The problems that I described,
however, occur only with 2.4.22 - the same machines with the same
configuration work just fine with 2.4.20. Maybe, there's
something else involved, too?

Regards,
                Peter


