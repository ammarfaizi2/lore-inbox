Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTEDKDX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 06:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTEDKDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 06:03:23 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:15243 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S263579AbTEDKDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 06:03:22 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Anders Karlsson" <anders@trudheim.com>,
       "LKML" <linux-kernel@vger.kernel.org>
Subject: RE: comparison between signed and unsigned
Date: Sun, 4 May 2003 11:15:45 +0100
Message-ID: <BKEGKPICNAKILKJKMHCACEFGCKAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1052040732.25950.4.camel@marx>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders.

 > Sitting here watching the compile output from 2.4.21-rc1-ac4 and
 > noticing there is a _lot_ of warnings about comparisons between
 > signed and unsigned values. The question I have is the following.
 > If all the signed values were modified to unsigned to fix the
 > warnings, how likely are things to break? Is there any reason to
 > use signed values unless a specific reason when negative values
 > are required?

The obvious question is this: How many of those warnings also occur
with the pristine source - i.e., the -rc1 without the -ac4 source. It
would probably be best to wade through the -rc1 sources fixing those
first, then worry about the -ac* sources once those have been merged
in.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.476 / Virus Database: 273 - Release Date: 24-Apr-2003

