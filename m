Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWADNOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWADNOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 08:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWADNOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 08:14:11 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:8631 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S1751104AbWADNOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 08:14:10 -0500
Message-ID: <43BBCA19.4090604@cosmosbay.com>
Date: Wed, 04 Jan 2006 14:14:01 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
References: <20051108185349.6e86cec3.akpm@osdl.org>	<437226B1.4040901@cosmosbay.com>	<20051109220742.067c5f3a.akpm@osdl.org>	<4373698F.9010608@cosmosbay.com>	<43BB1178.7020409@cosmosbay.com> <20060104034534.45d9c18a.akpm@osdl.org>
In-Reply-To: <20060104034534.45d9c18a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 04 Jan 2006 14:14:01 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
>> [PATCH] shrink the fdset and reorder fields to give better multi-threaded 
>>  performance.
> 
> Boy, this is going to need some elaborate performance testing..
> 
> We can't have that `8 * sizeof(embedded_fd_set)' splattered all over the
> tree.  This? 
>

Fine patch Andrew :)

I was a bit unsure of introducing a XXXX_SIZE macro expressed in bits instead 
of bytes (more natural unit at least for us humans)

Thank you
Eric



