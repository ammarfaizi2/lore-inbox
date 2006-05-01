Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWEANkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWEANkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWEANkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:40:52 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:65226 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S932098AbWEANkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:40:51 -0400
Message-ID: <44560FE0.2000004@voltaire.com>
Date: Mon, 01 May 2006 16:40:48 +0300
From: Or Gerlitz <ogerlitz@voltaire.com>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Or Gerlitz <or.gerlitz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       open-iscsi@googlegroups.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Christoph Lameter <clameter@sgi.com>
Subject: Re: [openib-general] Re: possible bug in kmem_cache related code
References: <Pine.LNX.4.44.0604271138370.16357-101000@zuben>	<84144f020604270419s10696877he2ec27ae6d52e486@mail.gmail.com>	<Pine.LNX.4.64.0604271510240.27370@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0604281108110.12202@sbz-30.cs.Helsinki.FI>	<15ddcffd0604281224i4308b08fs93f9ebaf7e9a16b3@mail.gmail.com> <1146293055.11279.2.camel@localhost>
In-Reply-To: <1146293055.11279.2.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2006 13:40:49.0695 (UTC) FILETIME=[DB9652F0:01C66D24]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On Fri, 2006-04-28 at 21:24 +0200, Or Gerlitz wrote:
>> Yes, i can reproduce this at will, no local modifications, my system
>> is amd dual x86_64, i have attached my .config to the first email of
>> this thread, and also mentioned that some CONFIG_DEBUG_ options are
>> set, including one related to slab debugging.
>>

> Yeah, arch/um/. Unfortunately I don't have a SMP box, so I probably
> can't reproduce this. You could try git bisect to isolate the offending
> changeset.

mmm, I might be able to do git bisection later this week or next week.

However, for the mean time can more people of the openib and open iscsi 
communities set 2.6.17-rcX to see that the issue reproduces with my 
synthetic module and with ib/iscsi code (you know this kernel will be 
out in few weeks from now...)

Or.

