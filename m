Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264357AbUEIQ5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbUEIQ5P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 12:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUEIQ5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 12:57:14 -0400
Received: from mail.tmr.com ([216.238.38.203]:16912 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264357AbUEIQ5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 12:57:13 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: RE : 2.6.6-rc3-mm2 : REGPARAM forced => no external module with
   some object code only
Date: Sun, 09 May 2004 13:03:29 -0400
Organization: TMR Associates, Inc
Message-ID: <c7lnng$4fo$2@gatekeeper.tmr.com>
References: <4098D65D.9010107@free.fr> <20040505131809.10bdcae6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084121648 4600 192.168.12.10 (9 May 2004 16:54:08 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040505131809.10bdcae6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Eric Valette <eric.valette@free.fr> wrote:
> 
>>The Changelog says nothing really important but forcing REGPARAM is 
>> rather important : it breaks any external module using object only code 
>> that calls a kernel function.
> 
> 
> This is why we should remove the option - to reduce the number of ways in
> which the kernel might have been built.  Yes, there will be a bit of
> transition pain while these people catch up.

Yes, I think that should go into the 2.7 tree as soon as it opens. Of 
course it wouldn't go in the 2.6 tree, that's stable, right?


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
