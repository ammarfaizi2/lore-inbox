Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWHIQe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWHIQe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWHIQe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:34:27 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:31391 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750740AbWHIQeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:34:25 -0400
Date: Wed, 09 Aug 2006 12:33:16 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [Alsa-user] another in kernel alsa update that breaks backward
 compatibilty?
In-reply-to: <s5h3bc5zy3q.wl%tiwai@suse.de>
To: linux-kernel@vger.kernel.org
Message-id: <200608091233.16264.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200608091140.02777.gene.heskett@verizon.net>
 <200608091207.26156.gene.heskett@verizon.net> <s5h3bc5zy3q.wl%tiwai@suse.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 12:13, Takashi Iwai wrote:
>At Wed, 09 Aug 2006 12:07:26 -0400,
>
>Gene Heskett wrote:
>> On Wednesday 09 August 2006 11:46, Sergei Steshenko wrote:
>> >On Wed, 09 Aug 2006 11:40:02 -0400
>> >
>> >Gene Heskett <gene.heskett@verizon.net> wrote:
>> >> Greetings;
>> >>
>> >> The old fart is back again. :)
>> >>
>> >> I've just done a divide and conquer on kernel versions, and have
>> >> found that while I DO have a kde audio signon for kernels
>> >> 2.6.18-rc1-rc3-rc4, I do not have any other functioning audio,
>> >> including the kde sound effects I normally get.  xmms and tvtime are
>> >> mute, as are the firefox plugins to play videos from the network.
>> >> 2.6.17.8 and below works great yet.
>> >>
>> >> So whats the fix?
>> >
>> >Demand stable ABI.
>>
>> It does not appear to be so.  And ATM booted to 18-rc1, I didn't see an
>> error message when rc.local made a call of "[root@coyote gene]# alsactl
>> restore
>> alsactl: set_control:894: warning: name mismatch (Mic Boost (+20dB)/Mic
>> Boost (+20dB) Switch) for control #45
>> alsactl: set_control:896: warning: index mismatch (0/0) for control #45
>> alsactl: set_control:898: failed to obtain info for control #45
>> (Operation not permitted)
>> [root@coyote gene]#
>
>This kind of problems can be fixed by calling "alsactl restore" with
>-F option.  The warnings may be still there but the values are handled
>better.
>
>The behavior with -F could be default, but it's kept so just for the
>compatibility reason.
>
>
Humm, and that fixed it for 2.6.18-rc4.  Gawd, I'd sure like to get some of 
that stuff, it must be great stuff.  Goes off scratching head & letting 
imagination work overtime.

>Takashi

Many thanks Takashi.
-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
