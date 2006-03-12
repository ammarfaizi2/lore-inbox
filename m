Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWCLMmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWCLMmB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 07:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWCLMmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 07:42:00 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:13902 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751417AbWCLMl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 07:41:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=rGEAKlzxMQkHhzM1hROT5pcFahN0DrQ1Bme11U3vhMM1vqjfLp3Fed4Dv/3yNwZ5jmHRodj1OHtE5bhqSL2umCPI82JnP5jNrEf5cQXtWNMu4X09g0GY+whDDpPnUXSfdEDpQ3zF2oH6YS2H5TmdSaRg5jXUQTT2Hok89CA0d8I=  ;
Message-ID: <44141710.3060407@yahoo.com.au>
Date: Sun, 12 Mar 2006 23:41:52 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: psycho@rift.ath.cx
CC: linux-kernel@vger.kernel.org,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
References: <20060312000621.GA8911@nexon>
In-Reply-To: <20060312000621.GA8911@nexon>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick wrote:

> ------------[ cut here ]------------
> kernel BUG at mm/rmap.c:486!
> EIP is at page_remove_rmap+0x30/0x40
>  [<c014c0b6>] zap_pte_range+0x156/0x250

This could easily be something that's already been fixed by now,
or it may still be a problem... can you test with the most recent
kernel (2.6.16-rc6)? Thanks.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
