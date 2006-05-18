Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWERIUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWERIUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWERIUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:20:23 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:48390 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750768AbWERIUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:20:22 -0400
Message-ID: <446C2E31.1010104@de.ibm.com>
Date: Thu, 18 May 2006 10:20:01 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chase Venters <chase.venters@clientec.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@sgi.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>,
       "hch@infradead.org" <hch@infradead.org>,
       "arjan@infradead.org" <arjan@infradead.org>, "ak@suse.de" <ak@suse.de>
Subject: Re: [RFC] [Patch 5/6] statistics infrastructure
References: <3741.1147913845@ocs3>
In-Reply-To: <3741.1147913845@ocs3>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Martin Peschke (on Wed, 17 May 2006 20:56:20 +0200) wrote:
>> This patch adds statistics infrastructure as common code.
>> +static int __devinit statistic_hotcpu(struct notifier_block *notifier,
>> +				      unsigned long action, void *__cpu)
> 
> __cpuinit for hotplug cpu, not __devinit.
> 

Fixed. Thank you.

Actually, I kernel/profile.c made me think __devinit was okay.
Anyone going to fix that one?

