Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVLZXbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVLZXbx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 18:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVLZXbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 18:31:53 -0500
Received: from hermes.domdv.de ([193.102.202.1]:24077 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S932156AbVLZXbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 18:31:52 -0500
Message-ID: <43B07D67.8090802@domdv.de>
Date: Tue, 27 Dec 2005 00:31:51 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.15rc6: ide oops+panic
References: <43AB20DA.2020506@domdv.de>	 <20051223053621.6c437cee.akpm@osdl.org>  <43B07A17.5040707@domdv.de> <1135639643.8293.91.camel@mindpipe>
In-Reply-To: <1135639643.8293.91.camel@mindpipe>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2005-12-27 at 00:17 +0100, Andreas Steinmetz wrote:
> 
>>Andrew Morton wrote:
>>
>>>Thanks.  Are you able to identify the most-recent kernel version which
>>>didn't do this?
>>>
>>
>>Bartlomiej's workaround (mount with "barrier=0") doesn't seem to help to
>>workaround the problem. I had one BUG/oops/panic (the same as reported)
>>after 96 hours of uptime and another one after only a few minutes of uptime.
>>
>>Some more info on the disk setup (all partitions including root):
>>
>>hda(1)/hdc(1)/hde(2) <-> 2x md raid5 <-> dm-crypt <-> lvm2 <-> ext3
> 
> 
> Stack overflow?

Hasn't x86_64 8k stacks?

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
