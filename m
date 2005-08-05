Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbVHEKcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbVHEKcV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbVHEKcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:32:21 -0400
Received: from hermes.domdv.de ([193.102.202.1]:12552 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262952AbVHEKcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:32:20 -0400
Message-ID: <42F34022.9040201@domdv.de>
Date: Fri, 05 Aug 2005 12:32:02 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cal Peake <cp@absolutedigital.net>
CC: Andrew Morton <akpm@osdl.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, pavel@suse.cz,
       davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
References: <42DD67D9.60201@stud.feec.vutbr.cz> <20050804142548.5b813700.akpm@osdl.org> <Pine.LNX.4.61.0508041741540.4557@lancer.cnet.absolutedigital.net>
In-Reply-To: <Pine.LNX.4.61.0508041741540.4557@lancer.cnet.absolutedigital.net>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake wrote:
> On Thu, 4 Aug 2005, Andrew Morton wrote:
> 
> 
>>Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
>>
>>>Does resuming from swsuspend work for anyone with amd64-agp loaded?
>>
>>It would seem not ;)
> 
> 
> Must have missed the OP. Yes I can resume fine from swsusp with amd64-agp.
> 
> System is an Averatec 3270 (Mobile Sempron(K8)).
> 
> Not that this helps at all other than confirming it is possible ;)
> 
> -cp
> 

AFAIK it works when agp is built into the kernel. You will get problems
when it is built as a module. In the module case you may want to try if
loading the module before resuming helps.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
