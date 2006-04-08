Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWDHAzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWDHAzh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 20:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWDHAzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 20:55:37 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:1179 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751373AbWDHAzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 20:55:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uJCfY+jvbOTKYczbSQSMWF7/ErzooZDTUvUxQcXl3TBAHOHtv6merSt932yCob0ANbZIfWBiIcmOOx99MV7zsxlMtgIHL5u14phbrCjbqn9suRx3Xv2R3+6wbLKNP3gYO90Knf1ZB4Ba7cXd1uWvf1iwYldr+YwzHcHAZweQagk=  ;
Message-ID: <443709F1.90906@yahoo.com.au>
Date: Sat, 08 Apr 2006 10:55:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: limit lowmem_reserve
References: <200604021401.13331.kernel@kolivas.org> <200604071902.16011.kernel@kolivas.org> <44365DC2.1010806@yahoo.com.au> <200604081015.44771.kernel@kolivas.org>
In-Reply-To: <200604081015.44771.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Friday 07 April 2006 22:40, Nick Piggin wrote:
> 

>>How would zone_watermark_ok always fail though?
> 
> 
> Withdrew this patch a while back; ignore
> 

Well, whether or not that particular patch isa good idea, it
is definitely a bug if zone_watermark_ok could ever always
fail due to lowmem reserve and we should fix it.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
