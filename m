Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWGYVh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWGYVh1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWGYVh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:37:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1718 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964870AbWGYVh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:37:26 -0400
Message-ID: <44C68F0E.2050100@redhat.com>
Date: Tue, 25 Jul 2006 17:37:18 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
References: <1153167857.31891.78.camel@lappy> <44C30E33.2090402@redhat.com> <Pine.LNX.4.64.0607241109190.25634@schroedinger.engr.sgi.com> <44C518D6.3090606@redhat.com> <Pine.LNX.4.64.0607251324140.30939@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607251324140.30939@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Mon, 24 Jul 2006, Rik van Riel wrote:
> 
>>> I think there may be a way with less changes to the way the VM functions to
>>> get there:
>> That approach probably has way too many state changes going
>> between the guest OS and the hypervisor...
> 
> An increment of a VM counter causes a state change in the hypervisor?

Christoph, please read more than the first 5 words in each
email before replying.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
