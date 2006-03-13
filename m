Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWCMCmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWCMCmO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 21:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWCMCmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 21:42:14 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:26744 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751474AbWCMCmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 21:42:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=BV7TgeaFMdIgQ6Bk/LVBxw4vHY0SgX3a92WEVhOKj2MFkyIRMgUBmj+dnQXDV0qqZTw+XcQGQj4FZeZB5V4YCmnU+g+AgN5Df0ywM2Ff+feznuPGv5Y1ZgnPmrW39x5LU+qrPBd0MTguH1KVMTWmFFElol7QzGwiZ91zN28EXbE=  ;
Message-ID: <4414DBFE.1050400@yahoo.com.au>
Date: Mon, 13 Mar 2006 13:42:06 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
CC: cc@ccrma.Stanford.EDU, Takashi Iwai <tiwai@suse.de>,
       alsa-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: 2.6.15-rt20, "bad page state", jackd (alsa	1.0.10
 vs. recent kernels)
References: <1141846564.5262.20.camel@cmn3.stanford.edu>	 <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>	 <1141938488.22708.28.camel@cmn3.stanford.edu>	 <4410B2D7.4090806@yahoo.com.au>	 <1141958866.22708.69.camel@cmn3.stanford.edu>	 <441109BC.9070705@yahoo.com.au>	 <1142016627.6124.33.camel@cmn3.stanford.edu>	 <44121351.2050703@yahoo.com.au> <1142210977.7471.27.camel@cmn3.stanford.edu>
In-Reply-To: <1142210977.7471.27.camel@cmn3.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Lopez-Lezcano wrote:

> Well, I found it. Finally. I diffed memalloc.c in the alsa kernel tree
> with alsa stable 1.0.10 and googled for the obvious two chunks that
> stood out :-)
> 

Well, good work on tracking it down. I guess you should forward
forward your patch to the ALSA guys.

[snip]

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
