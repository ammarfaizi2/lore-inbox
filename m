Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264274AbUEDJZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbUEDJZy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 05:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbUEDJZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 05:25:54 -0400
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:38856 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S264274AbUEDJZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 05:25:53 -0400
Message-ID: <40976199.1070300@techdrive.com.au>
Date: Tue, 04 May 2004 19:25:45 +1000
From: Richard James <richard@techdrive.com.au>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: CaT <cat@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3, nvidia sound, tulip eth and apic don't play well together
References: <20040502032253.GA6222@zip.com.au>
In-Reply-To: <20040502032253.GA6222@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT wrote:

>It's a case of one or the other really. If I try to use both at the same
>time they both die. The ethernet driver stops transmitting packets until
>I bring down the interface and then bringit back up and the sound stops
>playing, period.
>
>There are no kernel messages until the watchdog kicks in.
>
>Turning off APIC (I compiled it out) solves the problem totally. I'm now
>transferring files over the net and listening to my music without a 
>problem.
>
>  
>
This problem is being worked upon by Ross Dickson, Allen Martin, 
Bartlomiej Zolnierkiewicz and others. There are patches available. 
Search the messages in this list for messages with nforce2 in the 
subject line to read about the problem and solution. Currently it looks 
like we have a working solution.

Starting at
http://lkml.org/lkml/2004/4/12/172

Richard :)

