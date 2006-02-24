Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWBXVKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWBXVKS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWBXVKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:10:18 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:19036 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932495AbWBXVKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:10:16 -0500
Date: Fri, 24 Feb 2006 16:10:08 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Weird login, possibly related to rootkit Q
In-reply-to: <20060224190409.GB9384@kvack.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200602241610.08952.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200602230121.08670.gene.heskett@verizon.net>
 <20060224190409.GB9384@kvack.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 14:04, Benjamin LaHaise wrote:
>On Thu, Feb 23, 2006 at 01:21:07AM -0500, Gene Heskett wrote:
>> So we did a reinstall (rh9) without formatting because there was a
>> lot of non-replaceable data on it.  This also saved the logs, but
>> they are obviously not a lot of help when about 5 hours is missing
>> at about the time everything went to hell.
>
>Let's get this straight: your old Linux distro got rooted, so you
> installed an old Linux distro that no longer gets security updates to
> replace it. Why is that kernel related?  Sounds more like pebkac.

The version of php in the newer distros is not backards compatible and 
breaks most of the scripts used by the web page server (this box is its 
database) and that would require a lengthy rewrite of the php stuff on 
both machines, so the re-install of rh9 was the perceived easiest way 
out.  Its a commercial business whose web page gets 20k+ hits a day & 
downtime shouldn't be extended 2-3 days while re-writeing all of that 
as it took around 2 weeks to do it all originally.  Then at the end of 
the install, we edited the yum.conf to use the legacy servers and let 
it install/upgrade everything, a Gigabyte or so.

Had the php for say FC4 been backwards compatible, then obviously we 
would have taken a different path.  I don't think the yum.conf had been 
updated or installed even before this, and apt-get had, with its old 
paths in its config, also quit working quite some time back.

OTOH, if its gets hit again, then obviously we'll go to a newer distro 
and re-write the scripts.  It may even be time for Jim to learn how to 
use sed, and just globally replace the old with the new for each 
command.  But he's busy too, just having been handed responsibility for 
a bunch of G5's doing editing in news.  Too busy IMO, which is why I 
'came out of retirement' long enough to give him a hand & point 
directions to take while recovering.

>  -ben

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
