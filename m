Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTAOE07>; Tue, 14 Jan 2003 23:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTAOE07>; Tue, 14 Jan 2003 23:26:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:34187 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261456AbTAOE05>;
	Tue, 14 Jan 2003 23:26:57 -0500
Message-ID: <3E24E553.3090304@digeo.com>
Date: Tue, 14 Jan 2003 20:36:35 -0800
From: Andrew Morton <akpm@digeo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ryan <ryan@ryanflynn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.56 sound/oss/sb_mixer.c bounds check
References: <3E24D1D5.5090200@ryanflynn.com> <200301141930.00567.akpm@digeo.com> <3E24E1B2.3050308@ryanflynn.com>
In-Reply-To: <3E24E1B2.3050308@ryanflynn.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2003 04:35:44.0742 (UTC) FILETIME=[91630860:01C2BC4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ryan wrote:
>> Yup.
>>
>> It would be better to do:
>>
>>     if (dev < 0 || dev >= ARRAY_SIZE(smw_mix_regs))
> 
> 
> yup, much better. i did a little housecleaning on the whole file, as 
> well as 2 more bounds checks in appropriate places.
> 
> i'm sorry to ask, but i'm new -- i've got a ~500 line patch, and my 
> email client is wrapping at 80 chars (unfortunately some lines run over 
> 80 chars), is sending an attachment in ascii format ok? i've seen some 
> patches sent as attachments, not sure.
> 

Oh let me rant. You're using mozilla.  I just raised a bug against its cute habit of
mangling outgoing text.  I've just spent four days trying to find a workable Linux
email client (sophisticated UI, sophisticated IMAP support, sophisticated searching,
doesn't mangle incoming or outgoing messages) and have failed.  Netscape 4.x is
still the closest.

kmail is good, but its threading view is hopeless

evolution merrily mangles stuff and is buggy as a bunch of bananas.

Mozilla likes to go for multi-minute CPU burns if you try to handle a large amount
of data.  And it mangles outgoing patches.

Of the text-based MUA's pine is the only one which seems to have respectable IMAP
support, but the interface is klunky.

Sigh.  Where were we?  Oh yes.   Inline text is best, attachments are fine.
text/plain if poss.

<send, mangle>


