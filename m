Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270694AbTHAI7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 04:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275194AbTHAI7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 04:59:10 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:3826 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270694AbTHAI7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 04:59:07 -0400
Message-ID: <3F2A2C14.9030801@softhome.net>
Date: Fri, 01 Aug 2003 11:00:04 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Kumlien <pomac@vapor.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SHED][IO-SHED] Are we missing the big picture?
References: <fw7N.3DP.11@gated-at.bofh.it>
In-Reply-To: <fw7N.3DP.11@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Am I right - judging from your posting - that we finally reached 
moment than Linux will have network-like queueing disciplines for disks 
and CPUs?

   In any way, CPU/disk throughput just another types of limited resource.
   It would be nice to be able to manage it - who gets more, who gets 
less. CPU/disk schedulers by manageability are far behind network.
   IMHO must have for servers.

Ian Kumlien wrote:
> Hi all,
> 
> I have been following the sheduler and interactivity discussions closely
> but via the marc.theaimsgroup.com archive, So i might be behind etc...
> =P
> 
> [Note: sorry if i sound like mr.know-it-all etc, just trying to get a
> point across]
> 
> Anyways, i think that the AS discussions that i have seen has missed
> some points. Getting the processes priority in AS is one thing, but fist
> of all i think there should be a stand off layer. Let me explain:
> 
> I liked Jens Axobe's 'CBQ' alike implementation (based on the idea of
> Andrea A. (afair i have the names right) since it does the most
> important thing... which is *nothing* when there is no load (ie, pass
> trough).
> 
> AS might be/is the best damn io sheduler for loaded machines but when
> there is no load, it's overhead. So in my opinion there should be
> something that first warrants the usage of AS before it's actually
> engaged.
> 
> And, if it's only engaged during high load, additions like basing the
> requests priority on the process/tasks priority would make total sense,
> adding the 'wakeup on wait' or what it was would also make total
> sense... But how many of your machines uses the disk 100% of the time?
> (in the real world... )
> 
> I don't know how 'CBQ' was implemented but any 'we are under load now'
> trigger would do it for me.
> 
> Please see to it that my CC is included in any discussions =)
> 
> PS. Or was it a version of SFQ? in that case s/CBQ/SFQ/g
> DS.
> 


