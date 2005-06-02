Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFBQfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFBQfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVFBQfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:35:46 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:37529 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261187AbVFBQfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:35:43 -0400
Message-ID: <429F3532.80907@nortel.com>
Date: Thu, 02 Jun 2005 10:34:58 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Ingo Oeser <ioe-lkml@axxeo.de>, linux-kernel@vger.kernel.org
Subject: Re: [rfc] [patch] consolidate/clean up spinlock.h files
References: <20050602144004.GA31807@elte.hu> <200506021749.15206.ioe-lkml@axxeo.de> <20050602161633.GA12616@elte.hu>
In-Reply-To: <20050602161633.GA12616@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> the real call site info comes from dump_stack(). Maybe i should remove 
> the __FILE__,__LINE__ info altogether. (albeit a bit redundancy wont 
> hurt) I dont think we want to pass in __FILE__,__LINE__ all the way from 
> the main APIs.

Couldn't you make it a macro and hide the complexity?  Or is it just a 
performance issue due to register starvation?

Chris

