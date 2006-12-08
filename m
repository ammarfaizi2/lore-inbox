Return-Path: <linux-kernel-owner+w=401wt.eu-S1425513AbWLHNB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425513AbWLHNB2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 08:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425517AbWLHNB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 08:01:27 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:39454 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425513AbWLHNB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 08:01:27 -0500
Message-ID: <457962BF.5050202@hp.com>
Date: Fri, 08 Dec 2006 06:03:59 -0700
From: Rocky Craig <rocky.craig@hp.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: minyard@acm.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH 11/12] IPMI: Fix BT long busy
References: <20061202043921.GG30531@localdomain> <20061203132636.a7ac969d.akpm@osdl.org>
In-Reply-To: <20061203132636.a7ac969d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>In fact, please don't write macros.
>  
>
I see them all over the place (i.e., EXPORT_SYMBOL) so the request
is a little confusing to me...

> Please don't write macros which require that the caller have a particular
>
>local variable of a particular name.
>  
>
I could understand that, even if some people did agree with my desire
to increase legibility by decreasing visual clutter.  I think it also 
provides
some protection against typos in argument lists.

I'm (naively) curious as to why it's being flagged now as opposed to
two years ago when I submitted the original additions.

Have reviewers or review methods changed?

Have standards changed?

Did it just slip under someone's radar two years ago?

Regards,
Rocky Craig
HP Open Source and Linux Organization
