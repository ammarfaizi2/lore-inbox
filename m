Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264927AbRGEOFe>; Thu, 5 Jul 2001 10:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264744AbRGEOFY>; Thu, 5 Jul 2001 10:05:24 -0400
Received: from front1m.grolier.fr ([195.36.216.51]:24197 "EHLO
	front1m.grolier.fr") by vger.kernel.org with ESMTP
	id <S264669AbRGEOFL>; Thu, 5 Jul 2001 10:05:11 -0400
Subject: Re: VM Requirement Document - v0.0
From: Xavier Bestel <xavier.bestel@free.fr>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org,
        Tom spaziani <digiphaze@deming-os.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <0107051502510F.03760@starship>
In-Reply-To: <fa.jprli0v.qlofoc@ifi.uio.no> <fa.e66agbv.hn0u1v@ifi.uio.no>
	<002501c104f4$c40619b0$0701a8c0@morph>  <0107051502510F.03760@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 05 Jul 2001 16:00:02 +0200
Message-Id: <994341617.2070.1.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Jul 2001 15:02:51 +0200, Daniel Phillips wrote:
> Here's an idea I just came up with while I was composing this... along the 
> lines of using unused bandwidth for something that at least has a chance of 
> being useful.  Suppose we come to the end of a period of activity, the 
> general 'temperature' starts to drop and disks fall idle.  At this point we 
> could consult a history of which currently running processes have been 
> historically active and grow their working sets by reading in from disk.  
> Otherwise, the memory and the disk bandwidth is just wasted, right?  This we 
> can do inside the kernel and not require coders to mess up their apps with 
> hints.  Of course, they should still take the time to reengineer them to 
> reduce the cache footprint.

Well, on a laptop memory and disk bandwith are rarely wasted - they cost
battery life.

Xav

