Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132220AbRCVWhT>; Thu, 22 Mar 2001 17:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132224AbRCVWhK>; Thu, 22 Mar 2001 17:37:10 -0500
Received: from cable039.201.eneco.bart.nl ([195.38.201.39]:30227 "EHLO
	procyon.wilson.nl") by vger.kernel.org with ESMTP
	id <S132220AbRCVWgv>; Thu, 22 Mar 2001 17:36:51 -0500
From: "Michel Wilson" <mwilson@dds.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Multicast and IP-conntrack problem
Date: Thu, 22 Mar 2001 23:36:02 +0100
Message-ID: <NEBBLEJBILPLHPBNEEHIEEMCCAAA.mwilson@dds.nl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having some problems with ip-connection tracking and multicast packets:
the conntrack stuff doesn't seem to be able to handle multicast packets,
flooding my logs with messages like these:

Feb 28 15:53:00 procyon kernel: NAT: 0 dropping untracked packet c7105b00 1
195.38.203.147 -> 224.0.0.2
Feb 28 15:53:23 procyon kernel: NAT: 0 dropping untracked packet c7a13740 1
195.38.207.229 -> 224.0.0.2
Feb 28 15:53:26 procyon kernel: NAT: 0 dropping untracked packet c7a13740 1
195.38.207.229 -> 224.0.0.2
Feb 28 15:53:31 procyon kernel: NAT: 0 dropping untracked packet c6535a80 1
195.38.207.229 -> 224.0.0.2
Feb 28 15:54:18 procyon kernel: NAT: 0 dropping untracked packet c7a132c0 1
195.38.202.44 -> 224.0.0.2
Feb 28 15:54:21 procyon kernel: NAT: 0 dropping untracked packet c7a132c0 1
195.38.202.44 -> 224.0.0.2
(this is an old logfile, i disabled logging for these messages, because it
generated several megs each day)

I'm currently using kernel 2.4.0-test9, but a friend of mine is using 2.4.0
and is experiencing the same problem.

Is this a known problem which can't be fixed, or is it fixable? And am i
asking this question in the right place here?

Thanks for any help,

Michel Wilson
<michel@procyon14.yi.org>
<mwilson@dds.nl>

