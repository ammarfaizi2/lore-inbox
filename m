Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269457AbUJLFD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269457AbUJLFD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 01:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269458AbUJLFD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 01:03:26 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:18424 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269457AbUJLFDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 01:03:25 -0400
Message-ID: <416B6594.5080002@nortelnetworks.com>
Date: Mon, 11 Oct 2004 23:03:16 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3
References: <41672D4A.4090200@nortelnetworks.com> <1097503078.31290.23.camel@localhost.localdomain>
In-Reply-To: <1097503078.31290.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The OOM killer is a heuristic. 

Sure, but presumably it's a bad thing for a user with no priorities to be able 
to lock up a machine by running two tasks?  I'm not complaining that its killing 
the wrong thing, I'm complaining that the machine locked up.

 > Switch the machine to strict accounting
> and it'll kill or block memory access correctly.

I must be able to run an app that uses over 90% of system memory, and calls 
fork().  I was under the impression this made strict accounting unfeasable?

Chris
