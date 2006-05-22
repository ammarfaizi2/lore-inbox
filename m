Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWEVPBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWEVPBl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWEVPBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:01:41 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:4663
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750904AbWEVPBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:01:40 -0400
Message-Id: <4471EE9E.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Mon, 22 May 2006 17:02:22 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: Re: [PATCH 2/6, 2nd try] reliable stack trace support (x86-64)
References: <4471D5CC.76E4.0078.0@novell.com> <200605221608.18434.ak@suse.de>
In-Reply-To: <200605221608.18434.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 22.05.06 16:08 >>>
>On Monday 22 May 2006 15:16, Jan Beulich wrote:
>> These are the x86_64-specific pieces to enable reliable stack traces. The
>> only restriction with this is that it currently cannot unwind across the
>> interrupt->normal stack boundary, as that transition is lacking proper
>> annotation.
>
>that comment should be outdated now? 

Yes, if you consider the patches as a group (since the change that fixes this is in a later patch I wasn't really sure
how to deal with that part of the description).

Jan
