Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbTELNzS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTELNzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:55:18 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:45023 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262140AbTELNzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:55:16 -0400
Message-ID: <3EBFAA97.6030804@nortelnetworks.com>
Date: Mon, 12 May 2003 10:07:19 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug McNaught <doug@mcnaught.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC]  new syscall to allow notification when arbitrary pids die
References: <3EBC9C62.5010507@nortelnetworks.com>	<20030510073842.GA31003@actcom.co.il>	<3EBF144E.7050608@nortelnetworks.com>	<m3y91cj0vm.fsf@varsoon.wireboard.com>	<3EBF240A.4050706@nortelnetworks.com> <m3smrki9j3.fsf@varsoon.wireboard.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught wrote:

> No reason to have one FD per process monitored.  Just a single FD, to
> which you can write() a control string to to add or remove a process
> from the list, and for which read() yields a small data record
> describing the process event that just happened.  It's a bit plan-9ish
> but there's nothing wrong with that...

Ah, okay.  Interesting idea.  It would get around the limitation of having to 
use rt signals to get the queueing (though I'm not likely to hit that limit in 
any case).

Have to think about that one...

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

