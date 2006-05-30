Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWE3XVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWE3XVe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWE3XVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:21:33 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:18831 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP id S964806AbWE3XVc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:21:32 -0400
Message-ID: <447CD36A.1040201@nortel.com>
Date: Tue, 30 May 2006 17:21:14 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brian D. McGrew" <brian@visionpro.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Sharing memory between kernel and user space
References: <14CFC56C96D8554AA0B8969DB825FEA0012B331D@chicken.machinevisionproducts.com>
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B331D@chicken.machinevisionproducts.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2006 23:21:18.0823 (UTC) FILETIME=[C1583F70:01C6843F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian D. McGrew wrote:
> I'm using the 2.6.16.16 kernel.  Is there any chance that I could
> trouble you for a snippet of code to do that?  I've tried every
> combination I can think of.

You could try looking at how /dev/kmem does it.

Also, be aware that the size of "unsigned long" can vary between the 
kernel and userspace if you have a 64-bit machine.

Chris
