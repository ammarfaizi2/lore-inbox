Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVAMU05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVAMU05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVAMUXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:23:38 -0500
Received: from one.firstfloor.org ([213.235.205.2]:57539 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261383AbVAMTik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:38:40 -0500
To: sander@humilis.net
Cc: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: NUMA or not on dual Opteron
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
	<200501121824.44327.rathamahata@ehouse.ru>
	<Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org>
	<20050113094537.GB2547@favonius>
From: Andi Kleen <ak@muc.de>
Date: Thu, 13 Jan 2005 20:38:33 +0100
In-Reply-To: <20050113094537.GB2547@favonius> (sander@humilis.net's message
 of "Thu, 13 Jan 2005 10:45:37 +0100")
Message-ID: <m1sm552k7a.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander <sander@humilis.net> writes:

> Linus Torvalds wrote (ao):
>> On Wed, 12 Jan 2005, Sergey S. Kostyliov wrote:
>> > 2.6.10-rc1 hangs at boot stage for my dual opteron machine
>> 
>> Oops, yes. There's some recent NUMA breakage - either disable
>> CONFIG_NUMA, or apply the patches that Andi Kleen just posted on the
>> mailing list (the second option much preferred, just to verify that
>> yes, that does fix it).
>
> I was under the impression that NUMA is useful on > 2-way systems only.
> Is this true, and if not, under what circumstances is NUMA useful on
> 2-way Opteron systems?

I don't know who gave you this impression, but it's wrong. Using a
NUMA aware kernel is an advantage under many workloads on a 2way
Opteron system. 

>
> In other words: why should one want NUMA to be enabled or disabled for
> dual Opteron?

Because it is faster.

-Andi
