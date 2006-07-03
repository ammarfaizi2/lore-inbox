Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWGCWFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWGCWFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWGCWFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:05:11 -0400
Received: from dsl092-017-098.sfo4.dsl.speakeasy.net ([66.92.17.98]:2758 "EHLO
	baywinds.org") by vger.kernel.org with ESMTP id S932139AbWGCWFK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:05:10 -0400
Message-ID: <44A99486.6050307@baywinds.org>
Date: Mon, 03 Jul 2006 15:04:54 -0700
From: Bruce Ferrell <bferrell@baywinds.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>            <44A98D5A.5030508@tmr.com> <200607032150.k63LoM4H027543@turing-police.cc.vt.edu>
In-Reply-To: <200607032150.k63LoM4H027543@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 03 Jul 2006 17:34:18 EDT, Bill Davidsen said:
> 
>>I think he is talking about another problem. RAID addresses detectable
>>failures at the hardware level. I believe that he wants validation after
>>the data is returned (without error) from the device. While in most
>>cases if what you wrote and what you read don't match it's memory,
>>improving the chances of catching the error is useful, given that
>>non-server often lacks ECC on memory, or people buy cheaper non-parity
>>memory.
> 
> 
> There's other issues as well.  Why do people run 'tripwire' on boxes that
> have RAID on them?

Because they're looking for malicous changes
