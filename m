Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWFNPx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWFNPx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 11:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWFNPx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 11:53:57 -0400
Received: from fmr17.intel.com ([134.134.136.16]:4523 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S965018AbWFNPx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 11:53:56 -0400
Message-ID: <4490310C.9010601@linux.intel.com>
Date: Wed, 14 Jun 2006 08:53:48 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
References: <1150297122.31522.54.camel@lappy>
In-Reply-To: <1150297122.31522.54.camel@lappy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> Some folks find 128KB of env+arg space too little. Solaris provides them with
> 1MB. Manually changing MAX_ARG_PAGES worked for them so far, however they
> would like to run the supported vendor kernel.

then this patch should go to the vendors maybe ;)
> 
> In the interrest of not penalizing everybody with the overhead of just
> setting it larger, provide a sysctl to change it.
> 


why not go all the way and make it truely dynamic ?
