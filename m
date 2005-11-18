Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161170AbVKRUOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbVKRUOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbVKRUOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:14:17 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:49422 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1161170AbVKRUOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:14:16 -0500
Message-ID: <437E3617.8000207@superbug.demon.co.uk>
Date: Fri, 18 Nov 2005 20:14:15 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arijit Das <Arijit.Das@synopsys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Does Linux has File Stream mapping support...?
References: <7EC22963812B4F40AE780CF2F140AFE920904A@IN01WEMBX1.internal.synopsys.com>
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE920904A@IN01WEMBX1.internal.synopsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arijit Das wrote:
> Is it possible to have File Stream Mapping in Linux? What I mean is
> this...
> 
> FILE * fp1 = fopen("/foo", "w");
> FILE * fp2 = fopen("/bar", "w");
> FILE * fp_common = <Stream_Mapping_Func>(fp1, fp2);
> 
> fprint(fp_common, "This should be written to both files ... /foo and
> /bar");
> 
> So, what I am looking for is anything written to "fp_common" should
> actually be written to the streams fp1 and fp2.
> 
> Does Linux support this any way? Is there any way to achieve this...? Is
> there anything like <Stream_Mapping_Func>(above) ...?
> 
> Do pardon me if you feel that it is a wrong Forum to ask this question
> but I tried everywhere else and thought that implementers would best
> know about it, if at all anything like that exists.
> 
> Thanks,
> Arijit
> -

Why not just output to a file, and then use "tail -f filename"

