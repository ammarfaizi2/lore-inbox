Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbUKQKwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUKQKwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbUKQKwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:52:17 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:535 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262274AbUKQKur
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:50:47 -0500
Message-ID: <419B2CFC.7040006@tebibyte.org>
Date: Wed, 17 Nov 2004 11:50:36 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, andrea@novell.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       piggin@cyberone.com.au, riel@redhat.com,
       mmokrejs@ribosome.natur.cuni.cz, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
References: <4193E056.6070100@tebibyte.org> <4194EA45.90800@tebibyte.org> <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet> <20041114170339.GB13733@dualathlon.random> <20041114202155.GB2764@logos.cnet> <419A2B3A.80702@tebibyte.org> <419B14F9.7080204@tebibyte.org> <20041117012346.5bfdf7bc.akpm@osdl.org> <20041117060648.GA19107@logos.cnet> <20041117060852.GB19107@logos.cnet>
In-Reply-To: <20041117060852.GB19107@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo Tosatti escreveu:
> On Wed, Nov 17, 2004 at 04:06:48AM -0200, Marcelo Tosatti wrote:
> Before the swap token patches went in you remember spurious OOM reports  
> or things were working fine then?

The oom killer problems arose before and independently of the 
token-based-thrashing patches. I know this because I took a special 
interest in the tbtc patches too (which is why my test machine came to 
have 64MB RAM but 1GB swap).

Regards,
Chris R.
