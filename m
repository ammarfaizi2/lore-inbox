Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUJVVw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUJVVw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUJVVvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:51:50 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:60545 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267921AbUJVVqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:46:33 -0400
Message-ID: <41797FB2.4000300@nortelnetworks.com>
Date: Fri, 22 Oct 2004 15:46:26 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
Subject: Re: How is user space notified of CPU speed changes?
References: <1098399709.4131.23.camel@krustophenia.net>	 <1098444170.19459.7.camel@localhost.localdomain>	 <1098468316.5580.18.camel@krustophenia.net>	 <4179623C.9050807@nortelnetworks.com> <1098476905.19435.43.camel@localhost.localdomain>
In-Reply-To: <1098476905.19435.43.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2004-10-22 at 20:40, Chris Friesen wrote:
> 
>>x86 really could use an on-die register that increments at 1GHz independent of 
>>clock speed and is synchronized across all CPUs in an SMP box.

> HPET sort of is this but at chipset level

Right.  So you still have to go across the cpu bus to get it.

Chris
