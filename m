Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967190AbWK2OA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967190AbWK2OA3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967185AbWK2OA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:00:29 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:29496
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S967190AbWK2OA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:00:28 -0500
Message-Id: <456DA0EA.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 29 Nov 2006 14:02:02 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use probe_kernel_address in Dwarf2 unwinder
References: <456D79AB.76E4.0078.0@novell.com>
 <200611291415.13169.ak@suse.de>
In-Reply-To: <200611291415.13169.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 29.11.06 14:15 >>>
>On Wednesday 29 November 2006 12:14, Jan Beulich wrote:
>> Use probe_kernel_address() instead of __get_user() in Dwarf2 unwinder.
>
>I had already done this here. Thanks.

I had checked firstfloor and only found similar changes to arch/x86-64/.

Jan
