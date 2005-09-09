Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbVIIH4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbVIIH4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbVIIH4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:56:44 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:12756
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751437AbVIIH4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:56:43 -0400
Message-Id: <43215C9B02000078000247E4@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 09:57:47 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [discuss] [PATCH] add and handle NMI_VECTOR II
References: <43207DFC0200007800024543@emea1-mh.id2.novell.com>  <20050909004307.GA18347@wotan.suse.de>  <43214AE402000078000247AB@emea1-mh.id2.novell.com>  <200509090855.52752.ak@suse.de>  <4321525102000078000247C2@emea1-mh.id2.novell.com> <20050909071407.GI19913@wotan.suse.de>
In-Reply-To: <20050909071407.GI19913@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 09.09.05 09:14:07 >>>
>> ??? This is what the code doing the setup does. But the question was
-
>> what do you need the IDT entry for?
>
>Without an IDT entry you cannot receive it? 

But that's the point - if it's delivered as an NMI, it'll arrive
through vector 2 (the vector information specified is ignored).

Jan
