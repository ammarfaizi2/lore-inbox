Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVKJLvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVKJLvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 06:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVKJLvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 06:51:08 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:28677
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750786AbVKJLvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 06:51:07 -0500
Message-Id: <43734277.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 10 Nov 2005 12:52:07 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/39] NLKD/i386 - core adjustments
References: <43720FBA.76F0.0078.0@novell.com>  <43720FF6.76F0.0078.0@novell.com>  <43721024.76F0.0078.0@novell.com>  <4372105B.76F0.0078.0@novell.com>  <43721119.76F0.0078.0@novell.com>  <43721142.76F0.0078.0@novell.com>  <43721184.76F0.0078.0@novell.com>  <437211B6.76F0.0078.0@novell.com>  <20051109190017.GB4047@stusta.de>  <43730D3A.76F0.0078.0@novell.com> <20051110102936.GA5376@stusta.de>
In-Reply-To: <20051110102936.GA5376@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If there's a chance of a stack overflow the stack usage has to be 
>reduced until the chance goes down to 0.

How does one reduce stack usage in the presence of recursion driven by
user input (referring to expression evaluation)?

Also, NLKD has an extension to the (simplistic) pt_regs frame
(including e.g. floating point state) and may be used to debug itself
(i.e. there may be more than one frame on the stack at a time).

Jan
