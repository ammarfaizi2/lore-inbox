Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWBOTGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWBOTGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWBOTGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:06:18 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:48114 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S1751257AbWBOTGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:06:17 -0500
Date: Wed, 15 Feb 2006 11:05:30 -0800 (PST)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
In-Reply-To: <20060215151711.GA31569@elte.hu>
Message-ID: <Pine.LNX.4.64.0602151059300.14526@dhcp153.mvista.com>
References: <20060215151711.GA31569@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006, Ingo Molnar wrote:

>
> This patchset provides a new (written from scratch) implementation of
> robust futexes, called "lightweight robust futexes". We believe this new
> implementation is faster and simpler than the vma-based robust futex
> solutions presented before, and we'd like this patchset to be adopted in
> the upstream kernel. This is version 1 of the patchset.

 	Next point of discussion must be PI . Considering that this 
implementation is lacking it. Maybe it wouldn't be "lightweight" if it was 
included.

 	If PI is to be added to Linux it will need to encompass both 
mutex implementations . Was this a consideration in the design of these 
lightweight futexes?

Daniel
