Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbULQOvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbULQOvl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 09:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbULQOvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 09:51:41 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:7616 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261208AbULQOvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 09:51:39 -0500
Message-ID: <41C2F273.6010707@nortelnetworks.com>
Date: Fri, 17 Dec 2004 08:51:31 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Ross <chris@tebibyte.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac16
References: <1103222616.21920.12.camel@localhost.localdomain> <41C2DA43.9070900@tebibyte.org>
In-Reply-To: <41C2DA43.9070900@tebibyte.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ross wrote:
> 
> Alan Cox escreveu:
> 
>> Further small fixes for different minor things. A merge of some of the 
>> small
>> cleanups from Fedora work and also the fixes for the igmp and vc holes. 
> 
> 
> This kernel still suffers from the faulty OOM killing troubles of 
> vanilla 2.6.9. Could you please pick up at least one of the recent fixes 
> for this problem, such as as Rik van Riel's?

Can someone point me to his patch?  I've been working on and off to try and get 
reasonable OOM behaviour.  As it stands, 2.6.10-rc2-mm4 still shows nasty 
behaviour in OOM conditions, killing off more tasks than strictly required, and 
locking up the system for 10-15secs while doing it.

I'd be much happier doing a quick and dirty scan and knocking off something 
*now* rather than locking up the system.  Surely it can't take 60 billion cycles 
of cpu time to pick a task to kill.

Chris

