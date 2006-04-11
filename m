Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWDKMvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDKMvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 08:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWDKMvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 08:51:07 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:57853 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750809AbWDKMvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 08:51:06 -0400
Date: Tue, 11 Apr 2006 08:50:52 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: 2.6.16.1 breaks pipes and amanda
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200604110850.53092.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Amanda has failed on several, apparently randomly chosen disklist 
entries for the last 2 nights, due to what it calls a broken pipe in 
the dbg logs and in the email the dear girl sends me.

This is with amanda-2.5.0-20060405, which coverity says is totally 
clean.

Another problem being logged in the amanda-dbg directory is that the 
disklist entry prior to the failures in the logs had mysteriously been 
changed to use the DUMP program rather than GNUTAR, and none of my 
dle's use a dumptype specifying DUMP, all are GNUTAR.

I rebooted to plain 2.6.16 early this morning, and edited amanda's 
crontab to start a new backup 3 minutes after the edit, and amanda is 
now apparently happy again (for this run anyway).

There are no entries in the /var/log/messages file during the time of 
this mornings failure, nor were there any entries 
in /var/log/messages.1 for the previously failed runs time frame.

If the amanda logs for the failures should be posted, I have merged the 
20060411 logs from the dbg dir into one file, but its about 440k.  Your 
call.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
