Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbVK2Xaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVK2Xaf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVK2Xaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:30:35 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:37828 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751398AbVK2Xae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:30:34 -0500
Message-ID: <438CE416.3060707@t-online.de>
Date: Wed, 30 Nov 2005 00:28:22 +0100
From: Bernd Schmidt <bernds_cb1@t-online.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Nicholas Miell <nmiell@comcast.net>, Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <1133303615.3271.12.camel@entropy> <20051129224346.GS19515@wotan.suse.de>
In-Reply-To: <20051129224346.GS19515@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: EZ4AI6ZpYeP5snVJb-lKP9N3JBlJbSPPyfzUZG2H0jahAcgwKP2n4D
X-TOI-MSGID: 4f4791b1-d783-493a-9112-e0b58c24858e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> To give an bad analogy RDTSC usage in the last years is
> like explicit spinning wait loops for delays in the earlier
> times. They tended to work on some subset of computers,
> but were always bad and caused problems and people eventually learned
> it was better to use operating system services for this.
> 
> The kernel will probably not disable RDTSC outright,
> but will make it clear in documentation that it's a bad
> idea to use directly and laugh at everybody who runs
> into problems with it.

I happen to have an old program which uses RDTSC frequently for timing 
purposes.  That seemed like a good idea at the time, but I guess it 
should be updated.  The question is, what replacement is there?  I don't 
want to have to use a syscall every 50 instructions or so.  Feel free to 
laugh, but suggesting a workable replacement might be more helpful.


Bernd
