Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWBYTJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWBYTJX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbWBYTJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:09:23 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:47285 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1161071AbWBYTJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:09:08 -0500
Date: Sat, 25 Feb 2006 14:09:06 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [Announce] Intel PRO/Wireless 3945ABG Network Connection
In-reply-to: <Pine.LNX.4.61.0602251518200.31692@yvahk01.tjqt.qr>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200602251409.06493.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <43FF88E6.6020603@linux.intel.com>
 <200602250549.47547.gene.heskett@verizon.net>
 <Pine.LNX.4.61.0602251518200.31692@yvahk01.tjqt.qr>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 February 2006 09:19, Jan Engelhardt wrote:
>>If the modules crc changes,
>>it must do an instant disable of the transmitter functions and exit
>> or crash, thereby precluding any 'hot rodding' of the chipset.
>
>Would not it be easiest to have the chipset enforce the acceptable
> bands? So that software can't switch the chipset to 1337 GHz no
> matter how hard you forward/reverse-engineer it.

That removes the ability to legally use this chipset in regions other 
than the one its designed for.  We tend to forget that a set of masks 
to make a chip, in the currently fabbing 90nm process, can ran as high 
as 50 million dollars for the more complex stuff.  And it can only 
multiply when 45nm and even 15nm come online in the coming years. Such 
precision costs money, and must be recouped by sufficient volume of the 
single chip that mask set makes.

If Litchenstein has a different set of rules, I guarantee that there 
will NOT be a seperate chips masked out just for Litchenstein.

Sure, thats so ridiculous an example its sublime, but those are the 
facts that the chip makers must deal with on a global scale.  Its much 
easier for them to furnish a binary only driver that enforces the rules 
for the region where the chip will be used.  Economically, its the only 
choice they have.  I'd be interested in how, if they supply binaries 
that could supposedly be downloaded to anyplace on the planet, do they 
enforce in software the miriad variations of the rules.  It would have 
to have some means of discovering where it is in order to enable the 
proper subset of those rules.  That however, is also proprietary info 
because of the potential for hackability if the method were known.

>Jan Engelhardt

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
