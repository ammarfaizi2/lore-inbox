Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270183AbTGMI5l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 04:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270184AbTGMI5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 04:57:41 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:18405 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S270183AbTGMI5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 04:57:32 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "David Ford" <david+powerix@blue-labs.org>,
       "Ryan Underwood" <nemesis-lists@icequake.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Forking shell bombs
Date: Sun, 13 Jul 2003 10:10:22 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAOELCENAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3F0C2FCB.8060304@blue-labs.org>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

It sounds like what is required is some way of basically saying
"Don't permit new processes to be created if CPU usage > 75%"
(where the 75% is configurable but less than 100%).

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.



 > -----Original Message-----
 > From: linux-kernel-owner@vger.kernel.org
 > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of David Ford
 > Sent: Wednesday, July 09, 2003 4:08 PM
 > To: Ryan Underwood
 > Cc: linux-kernel@vger.kernel.org
 > Subject: Re: Forking shell bombs
 >
 > No such thing exists.  I can have 10,000 processes doing nothing and 
 > have a load average of 0.00.  I can have 100 processes each sucking cpu 
 > as fast as the electrons flow and have a dead box.
 >
 > Learn how to manage resource limits and you can tuck another feather 
 > into your fledgeling sysadmin hat ;)
 >
 > david
 >
 > Ryan Underwood wrote:
 >
 >> Hi,
 >>
 >> On Tue, Jul 08, 2003 at 04:43:18PM -0400, jhigdon wrote:
 >>
 >>> Have you tried this on any 2.5.x kernels? Just curious to see what it 
 >>> does, I plan on giving it a go later.
 >>
 >> I haven't, but a previous poster indicated that they had (2.5.74) with
 >> the same results.
 >>
 >> I wonder if we could find an upper limit on the number of allowable
 >> processes that would leave the box in a workable state?  Unfortunately,
 >> I don't have a spare box to test such things on at the moment. ;)
 >>
 >> Thanks,

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.500 / Virus Database: 298 - Release Date: 10-Jul-2003

