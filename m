Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVLNQ0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVLNQ0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVLNQ0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:26:47 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:26263 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964820AbVLNQ0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:26:46 -0500
Message-ID: <43A047C3.9060201@us.ibm.com>
Date: Wed, 14 Dec 2005 08:26:43 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: linux-kernel@vger.kernel.org, andrea@suse.de,
       Sridhar Samudrala <sri@us.ibm.com>, pavel@suse.cz,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 3/6] Slab Prep: get/return_object
References: <439FCECA.3060909@us.ibm.com> <439FD031.1040608@us.ibm.com> <84144f020512140019h1390c9eayf8b4b0dd03d8be1c@mail.gmail.com>
In-Reply-To: <84144f020512140019h1390c9eayf8b4b0dd03d8be1c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> Hi Matt,
> 
> On 12/14/05, Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
>>Create 2 helper functions in mm/slab.c: get_object() and return_object().
>>These functions reduce some existing duplicated code in the slab allocator
>>and will be used when adding Critical Page Pool support to the slab allocator.
> 
> 
> May I suggest different naming, slab_get_obj and slab_put_obj ?
> 
>                                             Pekka

Sure.  Those sound much better than mine. :)

-Matt
