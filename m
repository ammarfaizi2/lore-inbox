Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315464AbSEBXR7>; Thu, 2 May 2002 19:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315466AbSEBXR6>; Thu, 2 May 2002 19:17:58 -0400
Received: from jalon.able.es ([212.97.163.2]:59582 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315464AbSEBXR5>;
	Thu, 2 May 2002 19:17:57 -0400
Date: Fri, 3 May 2002 01:17:51 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020502231751.GA2003@werewolf.able.es>
In-Reply-To: <E173QdG-0000bs-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.03 Gerrit Huizenga wrote:
>In message <20020502173656.A26986@rushmore>, > : rwhron@earthlink.net writes:
>> On an OSDL 4 way x86 box the O(1) scheduler effect 
>> becomes obvious as the run queue gets large.  
>> 
>> 2.4.19-pre7-ac2 and 2.4.19-pre7-jam6 have the O(1) scheduler.  
>> 
>> At 192 processes, O(1) shows about 340% improvement in throughput.
>> The dyn-sched in -aa appears to be somewhat improved over the
>> standard scheduler.
>> 
>> Numbers are in MB/second.
>> 
>
>If you are bored, you might compare this to the MQ scheduler
>at http://prdownloads.sourceforge.net/lse/2.4.14.mq-sched
>
>Also, I think rml did a backport of the 2.5.X version of O(1);
>I'm not sure if htat is in -ac or -jam as yet.
>

-jam6 is sched-O1-rml-2 (the backport).

>Rumor is that on some workloads MQ it outperforms O(1), but it
>may be that the latest (post K3?) O(1) is catching up?
>

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam9 #2 SMP mié may 1 12:09:38 CEST 2002 i686
