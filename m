Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWEBTni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWEBTni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWEBTni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:43:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36992 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751153AbWEBTni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:43:38 -0400
Date: Tue, 2 May 2006 21:48:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060502194828.GB10072@elte.hu>
References: <20060419112130.GA22648@elte.hu> <200605021703.37195.ak@suse.de> <44577822.8050103@mbligh.org> <200605021745.32907.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605021745.32907.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> i386: Panic the system early when a NUMA kernel doesn't run on IBM 
> NUMA

nah! Lets just fix the zone sizing bug ...

	Ingo
