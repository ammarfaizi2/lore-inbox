Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVHRNan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVHRNan (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 09:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVHRNan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 09:30:43 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:29824 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S932222AbVHRNan
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 09:30:43 -0400
Message-ID: <43048D81.80402@ribosome.natur.cuni.cz>
Date: Thu, 18 Aug 2005 15:30:41 +0200
From: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050815
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: openafs is really faster on linux-2.4. than 2.6
References: <43032109.6030709@ribosome.natur.cuni.cz> <4304686F.20602@ribosome.natur.cuni.cz> <430483A2.9010605@ribosome.natur.cuni.cz> <200508182257.35544.kernel@kolivas.org>
In-Reply-To: <200508182257.35544.kernel@kolivas.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But that is very short and does not affect the interpretation here.
The throughput is clearly lower on 2.6 kernel and definitely the
CPU is in my eyes unnecessarily blocked... Why is the CPU in the
wait state instead of idle (this is teh problem on 2.6 series
but CPU is free on 2.4 series)? That's the main problem I think at the
moment.
M.

Con Kolivas wrote:
> On Thu, 18 Aug 2005 22:48, Martin MOKREJŠ wrote:
> 
>>I think the problem here is outside afs.
>>Just doing this dd test but writing data directly to the ext2
>>target gives same behaviour, i.e. on 2.4 kernel I see most of the
>>CPU idle but on 2.6 kernel all that CPU amount is shown as in
>>wait state. And the numbers from 2.4 kernel show higher throughput
>>compared to the 2.6 kernel (regardless the the PREEMPT or no PREEMPT
>>was used).
> 
> 
> Don't forget to include sync time.
