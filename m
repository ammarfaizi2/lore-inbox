Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263389AbUERUDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUERUDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 16:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUERUDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 16:03:42 -0400
Received: from bay8-f43.bay8.hotmail.com ([64.4.27.43]:48145 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S263389AbUERUDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 16:03:40 -0400
X-Originating-IP: [217.94.148.70]
X-Originating-Email: [v_atanaskovik@hotmail.com]
From: "Vladimir Atanaskovik" <v_atanaskovik@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with UDF and 2.6.5 kernel
Date: Tue, 18 May 2004 20:03:39 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY8-F43FOTC5M1KZUU00029f6b@hotmail.com>
X-OriginalArrivalTime: 18 May 2004 20:03:39.0755 (UTC) FILETIME=[364793B0:01C43D13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

when I try to access rewritable media (CD-RW, DVD+RW, DVD-RW) created with
DirectCD under Windows XP, then I experience the same problems like
described in:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108273859430365&w=2
(Subject: Unable to read UDF fs on a DVD)

However, if I try to access CD-R, DVD+R, DVD-R created by DirectCD and 
closed
in the way that new recording is not possible then at the first glance 
everything lokks fine.
The directory contens get's displayed when issuing the ls command. It is 
also
possible to cd to a directory on the media. However there are problems
when I attempt to copy files from a CD-R and DVD+/- R to the hard disc.

If the files size is <= 15 MB everything is OK! However with larger files
tehre is always an I/O error. I performed the tests with a NEC 1300 DVD 
writer
and a Samsung DVD ROM but the results were the same. It may be that the
"critical" file size differs on different systems.

In order to verify the media, I have performed the copy operation
under Windows XP and 2.4 kernel with an older UDF driver version.
There everything worked fine.

My kernel version is 2.6.5 and UDF V 0.9.8.1

Any idea, what may be wrong ?

Regards,
Vlad

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

