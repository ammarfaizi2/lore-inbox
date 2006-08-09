Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWHIUv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWHIUv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWHIUv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:51:56 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:32762 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751367AbWHIUvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:51:55 -0400
Date: Wed, 09 Aug 2006 16:51:27 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ALSA problems with 2.6.18-rc3
In-reply-to: <1155156090.26338.193.camel@mindpipe>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Benton <b3nt@ukonline.co.uk>,
       Takashi Iwai <tiwai@suse.de>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Message-id: <200608091651.28077.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <44D8F3E5.5020508@ukonline.co.uk>
 <200608091417.55431.gene.heskett@verizon.net>
 <1155156090.26338.193.camel@mindpipe>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 16:41, Lee Revell wrote:
[...]
>> >Takashi-san,
>> >
>> >Does this help at all?  Many users are reporting that sound broke with
>> >2.6.18-rc*.
>> >
>> >Lee
>>
>> Takashi-san's suggestion earlier today of running an "alsactl -F
>> restore" seems to have fixed all those diffs right up, I now have good
>> sound with an emu10k1 using an audigy 2 as card-0, running
>> kernel-2.6.18-rc4.
>
>Distros should probably be using this as a default.  Otherwise, simply
>adding a new mixer control will cause restoring mixer settings to fail.
>
>Lee

I already have the 'alsactl restore' in my rc.local.  Would there be any 
harm in just adding the -F to that invocation, or will that just restore 
it to a 'default' condition always.  Seems like it would, canceling 
anything you have done & then did an 'alsactl store' to save..

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
