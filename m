Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269557AbUJLJ2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269557AbUJLJ2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269563AbUJLJ2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 05:28:13 -0400
Received: from web52906.mail.yahoo.com ([206.190.39.183]:4774 "HELO
	web52906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269557AbUJLJ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 05:28:05 -0400
Message-ID: <20041012092804.73700.qmail@web52906.mail.yahoo.com>
Date: Tue, 12 Oct 2004 10:28:04 +0100 (BST)
From: Ankit Jain <ankitjain1580@yahoo.com>
Subject: Re: Difference in priority
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <416A7FE3.8090106@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry but iu could not get why are you adding and
subtracting this 60 in priorities. that corelation i
had also got but could not understrand whats this 60?
and also what is this dynamic priority? hows different
from normal priority

thanks

ankit
 --- Con Kolivas <kernel@kolivas.org> wrote: 
> Con Kolivas wrote:
> > Ankit Jain wrote:
> > 
> >> hi
> >>
> >> if somebody knows the difference b/w /PRI of both
> >> these commands because both give different
> results
> >>
> >> ps -Al
> >> & top
> >>
> >> as per priority rule we can set priority upto
> 0-99
> >> but top never shows this high priority
> > 
> > 
> > Priority values 0-99 are real time ones and
> 100-139 are normal 
> > scheduling ones. RT scheduling does not change
> dynamic priority while 
> > running wheras normal scheduling does (between
> 100-139). top shows the 
> > value of the current dynamic priority in the PRI
> column as the current 
> > dynamic priority-100. If you have a real time task
> in top it shows as a 
> > -ve value. ps -Al seems to show the current
> dynamic priority+60.
> 
> That should read dynamic priority-60 in the PRI
> column.
> 
> Cheers,
> Con
>  

________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
