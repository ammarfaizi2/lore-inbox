Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUBJWDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 17:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUBJWDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 17:03:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52236 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261827AbUBJWDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 17:03:11 -0500
Message-ID: <40295509.1050100@zytor.com>
Date: Tue, 10 Feb 2004 14:02:49 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
References: <1ne1M-1Oc-1@gated-at.bofh.it> <4029364F.9030905@tmr.com> <20040210215225.GA1666@thunk.org>
In-Reply-To: <20040210215225.GA1666@thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Tue, Feb 10, 2004 at 02:51:43PM -0500, Bill Davidsen wrote:
> 
>>Sorry, last reply "just went" for some reason... ijn any case I hope the 
>>number and tone of replies has shown that a number of people DO care, 
>>and that "you can just program around it with your effort instead of 
>>mine" isn't going to be popular.
>>
>>In other words, this sounds more like 2.7 material where people expect 
>>things to change than something which should just suddenly break in 2.6. 
>>Violation of Plauger's Law of Least Astonishment and all that.
> 
> 
> I think the discussion has always been that this would be a 2.7 item.  
> 
> However, it might be useful to make 2.6 start issueing printk's *now*
> when a program uses a BSD pty, so that application programs have
> plenty of notice that they will be going away.
> 

The way it looks right now it's not going to matter; it appears that
(optionally) continuing to supporting BSD ptys will "fall out naturally"
at least initially.

Ted, could I ask you to eyeball my patch to see how broken it is?

	-hpa

