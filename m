Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbTLBDYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 22:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTLBDYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 22:24:16 -0500
Received: from bay7-f71.bay7.hotmail.com ([64.4.11.71]:39690 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S264299AbTLBDYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 22:24:13 -0500
X-Originating-IP: [209.98.246.157]
X-Originating-Email: [joeblow341@hotmail.com]
From: "Joe Blow" <joeblow341@hotmail.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Promise 20378 + 2.6.0-test10 + libata patch 1
Date: Tue, 02 Dec 2003 03:24:11 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F71W9F0qnqEBQd00001253@hotmail.com>
X-OriginalArrivalTime: 02 Dec 2003 03:24:11.0719 (UTC) FILETIME=[C1257570:01C3B883]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>No plans.

Curiious:  How come when I disable RAID support in the BIOS and just have it 
<supposedly> act just like a dumb IDE controller, why aren't the drives 
aren't recognized that way?  The BIOS claims it is plugging them in as plain 
IDE drives, or is something still different about this controller, even in 
that mode?

>Using standard kernel drivers, Promise RAID _is_ md.

<confused> I understand what md is, but I don't understand how Promise RAID 
is md.  If I set the controller to RAID in the BIOS, and I configure a RAID 
1 mirror, for example, how is that md?  In this mode, isn't one copy of the 
data being sent to the controller and the controller "intelligence" figures 
out that one copy of the data goes to each drive?  Where is if it were 
providing two drives to the OS, the md driver would have to send two copies 
of the data across the bus, one to each drive?

Perhaps this is a dumb question, but why are these RAID controller companies 
seemingly making this so difficult?  To me it seems like the most logical 
way to design these controllers would be to make them look like standard IDE 
controllers to the system and hide the RAID complexities inside the 
controller intelligence.  The most expensive part of these controllers for 
the manufacturers has to be in providing drivers and support for all the 
different, primarily MS, OSes.  I must be missing something.

_________________________________________________________________
Gift-shop online from the comfort of home at MSN Shopping!  No crowds, free 
parking.  http://shopping.msn.com

