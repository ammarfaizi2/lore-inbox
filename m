Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWI2Bjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWI2Bjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 21:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWI2Bjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 21:39:48 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:24666 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751237AbWI2Bjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 21:39:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=u9vWc9ejx0PhfFF/rnRfYiljGH3JU5ENR1wVkBqz4SOTaVFOj5dpB5baOV2ZpA+ShPKFqmjx7N4BUNPx5t4h6RU4fsNljuMhC33uHVKQAtVx2Aain7vh1tnkhbsr1NNDZeij62Vrg38JhOGXXIZ2D7RdC4uuBNWx1jX2rj+ezec=  ;
Message-ID: <451C795E.3090500@yahoo.com.au>
Date: Fri, 29 Sep 2006 11:39:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom kill oddness.
References: <20060927205435.GF1319@redhat.com> <Pine.LNX.4.64.0609290035060.6762@scrub.home> <20060928171706.bee0c50b.akpm@osdl.org> <Pine.LNX.4.64.0609290231460.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0609290231460.6761@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

>Hi,
>
>On Thu, 28 Sep 2006, Andrew Morton wrote:
>
>
>>Kernel versions please, guys.  There have been a lot of oom-killer changes
>>post-2.6.18.
>>
>
>Last I tested this was with 2.6.18.
>The latest changes to vmscan.c should help...
>

It would be good if you could confirm that. I basically got the kernel to
the point where it used up all swap before going OOM on the workload I
was looking at (MySQL running in virtual machines).

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
