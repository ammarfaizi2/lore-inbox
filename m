Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVKAEdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVKAEdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVKAEdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:33:05 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:59560 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932566AbVKAEdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:33:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=T2asDsima+CP6Y7dkoar4M+qbLfjTJ1vj0xrTIyec2Pl+VixVbGqnYUHLveizp6207w4/CJOUiX5LHoYbT1CB4AtCn21wIZ//0ofOFZeVH2MFUBedtWAAWwC0pp1bD0h0ejff2EYiAnfrqsNAbrHryn9tdGrMYthkp6XIhCzvZs=  ;
Message-ID: <4366F061.8060006@yahoo.com.au>
Date: Tue, 01 Nov 2005 15:34:41 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/5] atomic: atomic_inc_not_zero
References: <436416AD.3050709@yahoo.com.au> <4364171C.7020103@yahoo.com.au> <43641755.5010004@yahoo.com.au> <4364178E.8040502@yahoo.com.au> <Pine.LNX.4.62.0510311104190.5528@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0510311104190.5528@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Maybe it would be best to put a definition of atomic_inc_zero into 
> asm-generic? Its the same for all arches that support cmpxchg.
> 

Yeah, I considered this. But there is a precedent for such duplication,
and as yet there is no common header file. So it does not belong in this
particular patch... not to say it is without merit though.

The arch maintainers I talked to generally didn't think it was a really
pressing issue, so I think I would leave such a consolidation patch for
someone else.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
