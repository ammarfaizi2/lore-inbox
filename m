Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWBWGVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWBWGVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 01:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWBWGVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 01:21:12 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:18852 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750822AbWBWGVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 01:21:12 -0500
Date: Thu, 23 Feb 2006 01:21:07 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Weird login, possibly related to rootkit Q
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200602230121.08670.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been asked to see if anyone has seen a case where a rh9 machine 
with one nic in it, but with 3 virtual addresses, apparently got 
rooted.

One address is 192.168.ish and the other two are assigned network 
addresses.  Symptoms were that all the usual admin tools were haveing 
their create date updated at one minute intervals to stay current, and 
anything we tried to do with them was a segfault.  And the machine was 
lagged terribly, with the cpu running 50F hotter than normal.  Cleaning 
and regreaseing the cpu & heatsink only helped about 10 degrees.  cpu 
fan is running good.

So we did a reinstall (rh9) without formatting because there was a lot 
of non-replaceable data on it.  This also saved the logs, but they are 
obviously not a lot of help when about 5 hours is missing at about the 
time everything went to hell.

One of the things left visible in the logs was an ssh login by root, 
from one of its ethernet addresses to another, but without a 
corresponding root login from an outside address!

Has anyone seen such a duck waddle by before?

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
