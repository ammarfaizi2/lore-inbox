Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTD3UaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 16:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbTD3UaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 16:30:19 -0400
Received: from kestrel.vispa.uk.net ([62.24.228.12]:23048 "EHLO
	kestrel.vispa.uk.net") by vger.kernel.org with ESMTP
	id S262378AbTD3UaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 16:30:17 -0400
Message-ID: <3EB0431D.3090705@walrond.org>
Date: Wed, 30 Apr 2003 22:41:49 +0100
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Matthew A. Miling" <mamiling@mailbox.syr.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Measuring CPU with Hyperthreading and Linux
References: <3EB61ACD@OrangeMail>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Run top, then press 1 to get a 'per cpu' usage line, rather than the 
default combined thing.

Obviously you'll need a threaded app to take advantage of the 
processors, and preferably a 2.5 kernel with  Ingo's HT scheduler patch...

Andrew

Matthew A. Miling wrote:
> Hello
> 
> Please personally CC my email address to any responses:
>   mamiling@syr.edu
> 
> I am currently running a dual Pentium 4 Xeon 2.4 GHz system containing Red Hat 
> Linux 6.2 with the 2.4.20 kernel.  The Pentium 4 Xeons report 4 cpu's to 
> /proc/cpuinfo because they are hyperthreaded.
> 
> My problem lies in trying to measure the CPU usage with such programs as top 
> or gtop.  Typically, I see CPU loads in excess of 100% when I run top with 
> some of my signal processing applications, but not more than 200%.  Is this 
> value out of 100%, 200%, or 400%?  How does this dual, HT system kernel report 
> this info to the OS?
> 
> Any help would be appreciated.  Thanks
> 

