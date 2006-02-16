Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWBPD3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWBPD3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWBPD3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:29:42 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:49504 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932090AbWBPD3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:29:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2x45OvdYED6BqV8N75RamlhbYoUMIJMIiPOBxQaO8JviFjUfj7lTejooOAdi5Tx3M5AJ18K9FET2AUyuD8mCuv6kDPX+IikHnLUsg//unVuyBWNUeEaW1w69bjeCXybkgZNoch/dp5t2X4kLEnVGmIyi2c5/BCQyaWHWcetiERw=  ;
Message-ID: <43F3F187.4040404@yahoo.com.au>
Date: Thu, 16 Feb 2006 14:29:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, rmk+lkml@arm.linux.org.uk,
       Ingo Molnar <mingo@elte.hu>, frankeh@watson.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP BUG
References: <43F12207.9010507@watson.ibm.com> <20060215230701.GD1508@flint.arm.linux.org.uk> <Pine.LNX.4.64.0602151521320.22082@g5.osdl.org> <20060215153013.474ff5e0.akpm@osdl.org> <Pine.LNX.4.64.0602151647260.22082@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602151647260.22082@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> So I like Rik's patch, but I don't feel _too_ strongly about it. The 
> people who actually work on the scheduler should be the ones to sign off 
> (or not) on it.
> 

I thought it looked fine. As you say, the scheduler can't work (and
will blow up) if init_idle() isn't called before it is used.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
