Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWJMGrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWJMGrx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 02:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWJMGrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 02:47:53 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:56218 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751201AbWJMGrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 02:47:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=05bU0eYufem+/X4eDi/CxgGRW6/ZmMqOo7FeZCSrja00pKCWZdiA9QHYbtVX7wx+n1JSFm6jJvAwi9f2jjsiTAHbrnRa009miCbM7hCZbJcUOvyPxfRp24F4vDxKatoo5qNpNAIlwxrn3gKycF0VTl0GWfOYGkuEBWOlORUFKgE=  ;
Message-ID: <452F3694.70104@yahoo.com.au>
Date: Fri, 13 Oct 2006 16:47:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <npiggin@suse.de>,
       Kirill Korotaev <dev@sw.ru>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/5] oom: invoke OOM killer from pagefault handler
References: <20061012120102.29671.31163.sendpatchset@linux.site>	<20061012120150.29671.48586.sendpatchset@linux.site>	<452E5B4D.7000402@sw.ru>	<20061012151907.GB18463@wotan.suse.de> <20061012150942.42e05898.akpm@osdl.org> <452F361D.1010306@yahoo.com.au>
In-Reply-To: <452F361D.1010306@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> What I especially have in mind here is the OOM_DISABLE and 
> panic_on_oom sysctl
> rather than expecting particularly much better general oom killing 
> behaviour.
> Suppose you have a critical failover node or heartbeat process or 
> something
> where you'd rather the system to panic and reboot instead of doing 
> something
> silly...


Oh, I already said that.

Well anyway, I'm not sure exactly how people use these tunables, but I 
expect
those that do, _really_ want them to work.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
