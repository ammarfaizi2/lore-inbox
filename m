Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWAUXx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWAUXx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 18:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWAUXx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 18:53:58 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:36522 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751225AbWAUXx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 18:53:58 -0500
Date: Sat, 21 Jan 2006 18:53:56 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
In-reply-to: <1137886206.11722.1.camel@mindpipe>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200601211853.56339.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060119030251.GG19398@stusta.de>
 <200601211826.02159.gene.heskett@verizon.net>
 <1137886206.11722.1.camel@mindpipe>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 January 2006 18:30, Lee Revell wrote:
>On Sat, 2006-01-21 at 18:26 -0500, Gene Heskett wrote:
>> On Wednesday 18 January 2006 22:02, Adrian Bunk wrote:
>> >Let's do the scheduled removal of the obsolete raw driver in
>> > 2.6.17.
>>
>> This thread has run on for a bit longer it seems, and it prompts me
>> to back up to the original post and ask if the raw driver you are
>> removing is the raw driver used when cups tells a device (a printer)
>> to do this file using the -o raw format?
>>
>> If this is the case, then a rather large amount of printing
>> functionality will be removed as a side effect.  I hope I'm
>> miss-understanding the intent here.
>
>No, it's a different raw driver, for big databases that basically want
>their own custom filesystem on a disk.

With the attendent possibility of rendering the whole thing 
unrecoverably moot?

OTOH, if this database actually does have a better way, and its mature 
and proven, then I see no reason to cripple the database people just to 
remove what is viewed as a potentially dangerous path to the media 
surface for the unwashed to abuse.

While I'm infinitely familiar with walking around and editing bits and 
bytes in a much older filesystem than ext3 (microwares os-9), there's 
no way in hell I'd try that where 200GB of data could go byby.  A 720k 
floppy can always be re-written, but not a truely huge filesystem, nuh 
uh unless you have bare metal backups.

But thats just me being a cautious old fart, but some of the database 
folks have decades of such experience and shouldn't be penalized for 
using what to them is the fastest way to do it, after all, speed is the 
very essence of a databases performance.  Its what they sell as the 
sizzle.  Methinks then that rather than give up that advantage, maybe a 
newer filesystem might be forthcoming from the db folks, one that 
preserves that perceived advantage, but only if that advantage can be 
protected from other db vendors being able to use it too.  Which would 
being up licenseing issues I'm sure, but thats another argument on 
another day.  Thats why this looks a bit like a lose-lose situation as 
it will hurt, rather than enhance, the overall linux performance.

My $0.02, adjust for inflation since 1934. :-)

>Lee

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
