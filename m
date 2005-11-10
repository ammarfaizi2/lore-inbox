Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbVKJIED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbVKJIED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 03:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVKJIED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 03:04:03 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:34992
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751379AbVKJIEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 03:04:02 -0500
Message-Id: <43730D3A.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 10 Nov 2005 09:04:58 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/39] NLKD/i386 - core adjustments
References: <43720F5E.76F0.0078.0@novell.com>  <43720F95.76F0.0078.0@novell.com>  <43720FBA.76F0.0078.0@novell.com>  <43720FF6.76F0.0078.0@novell.com>  <43721024.76F0.0078.0@novell.com>  <4372105B.76F0.0078.0@novell.com>  <43721119.76F0.0078.0@novell.com>  <43721142.76F0.0078.0@novell.com>  <43721184.76F0.0078.0@novell.com>  <437211B6.76F0.0078.0@novell.com> <20051109190017.GB4047@stusta.de>
In-Reply-To: <20051109190017.GB4047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Adrian Bunk <bunk@stusta.de> 09.11.05 20:00:17 >>>
>On Wed, Nov 09, 2005 at 03:11:51PM +0100, Jan Beulich wrote:
>> The core i386 NLKD adjustments to pre-existing code.
>> 
>> Signed-Off-By: Jan Beulich <jbeulich@novell.com>
>> 
>> (actual patch attached)
>
>If your code doesn't work with 4k stacks you have a problem because
>8k stacks will soon be removed (my goal is 2.6.16, perhaps one or two

>releases later).

It's not that it doesn't work with them, but chances of stack overflow
are too high for my taste.

Jan
