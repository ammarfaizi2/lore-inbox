Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWJMLGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWJMLGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 07:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWJMLGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 07:06:01 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:26897 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751059AbWJMLGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 07:06:00 -0400
Message-ID: <452F7303.6070303@superbug.co.uk>
Date: Fri, 13 Oct 2006 12:05:39 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.7 (X11/20060917)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net>	 <20061012171929.GB24658@flint.arm.linux.org.uk>	 <452E888D.6040002@comcast.net> <1160678231.3000.451.camel@laptopd505.fenrus.org>
In-Reply-To: <1160678231.3000.451.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2006-10-12 at 14:25 -0400, John Richard Moser wrote:
> 
> 
>>   - Does the current code act on these behaviors, or just flush all
>>     cache regardless?
> 
> the cache flushing is a per architecture property. On x86, the cache
> flushing isn't needed; but a TLB flush is. Depending on your hardware
> that can be expensive as well. 
> 

So, that is needed for a full process context switch to another process.
 Is the context switch between threads quicker as it should not need to
flush the TLB?

James

