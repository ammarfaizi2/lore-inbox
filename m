Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbVHZQkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbVHZQkw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 12:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbVHZQkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 12:40:52 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:57051 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S965102AbVHZQkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 12:40:52 -0400
Message-ID: <430F45F8.8020505@nortel.com>
Date: Fri, 26 Aug 2005 10:40:24 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Sat." <walking.to.remember@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: when or where can the case occur in "linux kernel development
 " about "kernel preemption"?
References: <6b5347dc05082609206ff7a305@mail.gmail.com>
In-Reply-To: <6b5347dc05082609206ff7a305@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sat. wrote:
> the case about kernel preemption as follow :
> 
> the book said "when a process that has a higher priority than the
> currenty running process is awakened ".
> 
> but I can think about when such case can occur , could you give me an example ?

There may be others, but one common case is when a hardware interrupt 
causes the higher priority process to become runnable.  Some examples of 
this would be a network packet arriving, or the expiry of a hardware timer.

Chris
