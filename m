Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWHIBe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWHIBe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWHIBe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:34:57 -0400
Received: from smtp-out.google.com ([216.239.45.12]:25322 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030401AbWHIBe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:34:56 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=VJEWp4pkpTKYD8A3JTdbAlqmXVQmTbFWq8L3FDQsVPgomL3YsmU7Hp8BRXHhQXZti
	HqRNkqccMl5F0c1fTPL+w==
Message-ID: <44D93BB3.5070507@google.com>
Date: Tue, 08 Aug 2006 18:34:43 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Graf <tgraf@suug.ch>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060808193345.1396.16773.sendpatchset@lappy> <20060808211731.GR14627@postel.suug.ch>
In-Reply-To: <20060808211731.GR14627@postel.suug.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Graf wrote:
  > skb->dev is not guaranteed to still point to the "allocating" device
> once the skb is freed again so reserve/unreserve isn't symmetric.
> You'd need skb->alloc_dev or something.

Can you please characterize the conditions under which skb->dev changes
after the alloc?  Are there writings on this subtlety?

Regards,

Daniel

