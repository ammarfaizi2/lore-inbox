Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUD1TRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUD1TRQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUD1TOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:14:38 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:13461 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S264989AbUD1RSX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 13:18:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BK PATCH] add SMBIOS tables to sysfs
Date: Wed, 28 Apr 2004 12:18:21 -0500
Message-ID: <0960978B185D2848BF5BBAE1BFB343E104E3EC@ausx2kmps315.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BK PATCH] add SMBIOS tables to sysfs
Thread-Index: AcQtQRIGJnJy6rFaTCSp/wP5rb0piwAAyGEQ
From: <Michael_E_Brown@Dell.com>
To: <greg@kroah.com>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>, <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 28 Apr 2004 17:18:22.0309 (UTC) FILETIME=[CEC26950:01C42D44]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com] 
> 
> Ok, here are 2 patches.  The first small one is on top of your latest
> version.  It gets rid of the extra subdirectory, and removes the
> unneeded kobject from your static structure (NEVER USE A KOBJECT IN A
> STATIC STRUCTURE!!!!)

Ok, thanks for the guidance here. I was not aware of this limitation. 

> The secone one is against a clean 2.6.6-rc3 kernel that has 
> your latest
> version + my changes.
> 
> If you approve of my changes, I'd be glad to add the driver to my bk
> trees to have it show up in the next -mm release, and I will 
> push it off
> to Linus after 2.6.6 is out.  Sound ok?

This looks good. I'll do a quick compile/boot check. I would really 
appreciate your help in getting this in. (although I was hoping to get
it into 2.6.6, I guess it can wait for 2.6.7 :-)
--
Michael
