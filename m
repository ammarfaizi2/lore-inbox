Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUBXJSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 04:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbUBXJSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 04:18:03 -0500
Received: from everest.2mbit.com ([24.123.221.2]:48359 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S262217AbUBXJSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 04:18:00 -0500
Message-ID: <403B169E.4000006@greatcn.org>
Date: Tue, 24 Feb 2004 17:17:18 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
Organization: GreatCN.org & The Summit Open Source Develoment Group
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
References: <c16rdh$gtk$1@terminus.zytor.com>	<4039D599.7060001@greatcn.org>	<20040223151815.GA403@zaniah>	<403AB897.8070002@greatcn.org> <20040223205522.66d7fb4f.rddunlap@osdl.org>
In-Reply-To: <20040223205522.66d7fb4f.rddunlap@osdl.org>
X-Scan-Signature: e39eceae6eb4554774934c39b07fdc9c
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: Re: Does Flushing the Queue after PG REALLY a Necessity?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 3.1 (built Tue Oct 14 21:11:59 EST 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> On Tue, 24 Feb 2004 10:36:07 +0800 Coywolf Qi Hunt wrote:
> 
> | Right, I also think removing the flush code is risky. Thanks very much, 
> | chapter 18 is what i was looking for. I recalled in an old intel 
> | booklet, named like something 386 system guide, says JMP after PG as 
> | well as PE. But I didn't have that book at hand and didn't find any e-doc.
> 
> I guess that's the 80386 System Software Writer's Guide.
> Ch. 6: Initialization.
> Yes, it does JMP after setting PE and after enabling PG.
> Any JMP.

Yes, it's that booklet, very thin.

> 
> | However, in 18.27.3, "The sequence bounded by the MOV and JMP 
> | instructions should be identity" implies no JMP is also viable 
> | practically. But we needn't to be that pedantic.
> | 
> | If no any reason for the two jumps, the code should be fixed to remains 
> | only ONE near jump.


Btw, could you please do not show others email address when you reply? 
Change your mail client's configuration. I don't like my this email 
address be grabbed by spammers. thanks


	Coywolf



-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org
