Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUJVTsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUJVTsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267376AbUJVTp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:45:59 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:59901 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267338AbUJVTkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:40:55 -0400
Message-ID: <4179623C.9050807@nortelnetworks.com>
Date: Fri, 22 Oct 2004 13:40:44 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
Subject: Re: How is user space notified of CPU speed changes?
References: <1098399709.4131.23.camel@krustophenia.net>	 <1098444170.19459.7.camel@localhost.localdomain> <1098468316.5580.18.camel@krustophenia.net>
In-Reply-To: <1098468316.5580.18.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> Seems like you are implying that any userspace app that needs to know
> the CPU speed is broken.  Is this correct?

No, we're saying that Intel's tsc implementation is broken.  <grin>

x86 really could use an on-die register that increments at 1GHz independent of 
clock speed and is synchronized across all CPUs in an SMP box.

Chris
