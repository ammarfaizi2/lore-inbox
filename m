Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUBZTbu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbUBZTaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:30:11 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:19154 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262965AbUBZT2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:28:46 -0500
Message-ID: <403E48D3.5050805@watson.ibm.com>
Date: Thu, 26 Feb 2004 14:28:19 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030829 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Peter Williams <peterw@aurema.com>, Nuno Silva <nuno.silva@vgertech.com>,
       Timothy Miller <miller@techsource.com>, John Lee <johnl@aurema.com>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <403D7531.5060309@aurema.com> <Pine.LNX.4.44.0402261054510.5629-200000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402261054510.5629-200000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Thu, 26 Feb 2004, Peter Williams wrote:
> 
> 
>>Another idea that we are playing with for handling programs like xmms 
>>(i.e. programs that require gauranteed CPU bandwidth to perform well) is 
>>the complement of caps namely per task CPU reservations.
> 
> 
>>Of course, this won't solve the "need to be root" problem as this is 
>>obviously the sort of control that should be reserved for root
> 
> 
> Not necessarily.  We've just fixed this dilemma in the CKRM
> project, using a resource class filesystem for this kind of
> stuff.
> 
> A user could have a certain percentage of the CPU guaranteed
> (especially the console user) and carve out part of his/her
> guarantee for multimedia applications.
> 
> Please see the attached document, which is the 6th draft of
> this particular CKRM design.  If you have any improvements
> for this spec, feel free to let us know ;)


The CKRM API has also been posted separately as an RFC on lkml
today...just in case its missed deep down in this thread !



-- Shailabh






