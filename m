Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUHOMhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUHOMhG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 08:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUHOMhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 08:37:06 -0400
Received: from everest.2mbit.com ([24.123.221.2]:9884 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S266663AbUHOMhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 08:37:02 -0400
Message-ID: <411F58DF.2070002@greatcn.org>
Date: Sun, 15 Aug 2004 20:36:47 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
CC: linux-kernel@vger.kernel.org
References: <E1BwJne-0006M7-00@calista.eckenfels.6bone.ka-ip.net>
In-Reply-To: <E1BwJne-0006M7-00@calista.eckenfels.6bone.ka-ip.net>
X-Scan-Signature: fad39d3eb0bc82a8daaaab38959dee5c
X-SA-Exim-Connect-IP: 218.24.189.67
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: Re: [PATCH] Remove obsolete HEAD in top Makefile
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.189.67 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0+cvs20040712 (built Mon, 09 Aug 2004 23:30:37 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:

>In article <411F3A48.2030201@greatcn.org> you wrote:
>  
>
>>Now the 2.6 kbuild is no longer using it. I have tested it.
>>    
>>
>...
>  
>
>>-head-y += $(HEAD)
>>vmlinux-objs := $(head-y) $(init-y) $(core-y) $(libs-y) $(drivers-y) 
>>$(net-y)
>>    
>>
>
>
>iff it is not using it you need to remove it in the next line, too.
>  
>

Nah, I'm only removing HEAD, not head-y. :p


-- 
Coywolf Qi Hunt
Homepage http://greatcn.org/~coywolf/
Admin of http://GreatCN.org and http://LoveCN.org

