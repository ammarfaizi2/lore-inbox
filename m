Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWAEX1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWAEX1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWAEX1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:27:15 -0500
Received: from c-67-174-241-67.hsd1.ca.comcast.net ([67.174.241.67]:16334 "EHLO
	plato.virtuousgeek.org") by vger.kernel.org with ESMTP
	id S1751219AbWAEX1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:27:12 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Date: Thu, 5 Jan 2006 15:27:05 -0800
User-Agent: KMail/1.9
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
References: <43BC716A.5080204@mbligh.org> <20060105225513.GA1570@elte.hu> <20060105231150.GR3356@waste.org>
In-Reply-To: <20060105231150.GR3356@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051527.05817.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 5, 2006 3:11 pm, Matt Mackall wrote:
> I'm still not sure about in-source annotations for popularity. My
> suspicion is that it's just too workload-dependent, and a given
> author's workload will likely be biased towards their code.

To some extent that's true, but like Linus implied with his "5% work gets 
us 80% there" I think there are a ton of obvious cases, e.g. kmalloc, 
alloc_pages, interrupt handling, etc. that could be marked right away 
and put into a frequently used section.

Jesse
