Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTE2HCX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 03:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTE2HCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 03:02:23 -0400
Received: from netmail01.services.quay.plus.net ([212.159.14.219]:47088 "HELO
	netmail01.services.quay.plus.net") by vger.kernel.org with SMTP
	id S261939AbTE2HCV (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 29 May 2003 03:02:21 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Marc Wilson" <msw@cox.net>
Cc: "Linux Kernel List" <Linux-Kernel@vger.kernel.org>
Subject: RE: Linux 2.4.21-rc6
Date: Thu, 29 May 2003 08:15:39 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAMEAPECAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030529055735.GB1566@moonkingdom.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc.

 >> The basic problem there is that any mail client needs to know
 >> just how many messages are in a particular folder to handle that
 >> folder, and the only way to do this is to count them all. That's
 >> what takes the time when one opens a large folder.

 > No, the basic problem there is that the kernel is deadlocking.
 > Read the VERY long thread for the details.
 >
 > I think I have enough on the ball to be able to tell the difference
 > between mutt opening a folder and counting messages, with a counter
 > and percentage indicator advancing, and mutt sitting there
 > deadlocked with the HD activity light stuck on and all the rest of
 > X stuck tight.

I thought I was on the ball when a similar situation happened to me.
What I observed was that the counters and percentage indicators were
NOT advancing for about 30 seconds, and both would then jump up by
about 70 messages and the relevant percent rather than counting
smoothly through. It was only when I noticed those jumps that I went
back to basics and analysed the folder rather than the kernel.

However, I apologise profusely for assuming that my experience in what
to me appear to be similar circumstances to yours could have any sort
of bearing on the problem you are seeing.

 > And it just happened again, so -rc6 is no sure fix. What did y'all
 > that reported the problem had gone away do, patch -rc4 with the
 > akpm patches?

In my case, I fixed the problem by splitting the relevant folder up,
as stated in my previous message. However, such a solution apparently
doesn't work for you, so I'm unable to help any further.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.484 / Virus Database: 282 - Release Date: 27-May-2003

