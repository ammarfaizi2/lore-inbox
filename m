Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWINVHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWINVHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWINVHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:07:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:53405 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751089AbWINVHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:07:41 -0400
Date: Thu, 14 Sep 2006 23:07:14 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Martin Bligh <mbligh@mbligh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060914203430.GB9252@elte.hu>
Message-ID: <Pine.LNX.4.64.0609142302180.6761@scrub.home>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
 <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu>
 <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu>
 <4509BAD4.8010206@mbligh.org> <20060914203430.GB9252@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Sep 2006, Ingo Molnar wrote:

> primarily because i fail to see any property of static tracers that are 
> not met by dynamic tracers. So to me dynamic tracers like SystemTap are 
> a superset of static tracers.

You keep ignoring that a dynamic tracer is nontrivial... :-(
A static tracer is easy to implement and sufficient for many uses and 
most important it doesn't prevent anyone from using a dynamic tracer. 
Having a choice is good!

bye, Roman
