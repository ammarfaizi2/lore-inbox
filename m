Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTESDpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 23:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTESDpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 23:45:07 -0400
Received: from pop.gmx.de ([213.165.64.20]:28496 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262324AbTESDpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 23:45:06 -0400
Message-Id: <5.2.0.9.2.20030519054623.01d922a8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 19 May 2003 06:02:26 +0200
To: <linux-kernel@vger.kernel.org>
From: Mike Galbraith <efault@gmx.de>
Subject: RE: Scheduling problem with 2.4?
Cc: "David Schwartz" <davids@webmaster.com>,
       "Andrea Arcangeli" <andrea@suse.de>, <dak@gnu.org>
In-Reply-To: <5.2.0.9.2.20030518103757.00ce93e8@pop.gmx.net>
References: <MDEHLPKNGKAHNMBLJOLKIELBDAAA.davids@webmaster.com>
 <20030517235048.GB1429@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:55 AM 5/18/2003 +0200, Mike Galbraith wrote:
>At 05:16 PM 5/17/2003 -0700, David Schwartz wrote:
>
>>         I suggest that a process be permitted to use up at least some 
>> portion of
>>its timeslice exempt from any pre-emption based solely on dynamic
>>priorities.
>
>
>Is there any down-side to not preempting quite as often?  It seems like 
>there should be a bandwidth gain.

(my reply was supposed to be off-list, but..)

The answer appears to be yes, there are down-sides.  Instead of the 
expected throughput gain, I got a loss :-/  which makes sense from the 
cache side I suppose.  While it was instant gratification for the pipe 
testcase, as a general solution it leaves something to be desired... at 
least when implemented in it's simplest form  Oh well.

(hmm.. maybe I should go stare at the cache decay stuff some more.  later)

         -Mike 

