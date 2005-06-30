Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVF3Ofw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVF3Ofw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 10:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVF3Ofw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 10:35:52 -0400
Received: from host27-37.discord.birch.net ([65.16.27.37]:3936 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S262736AbVF3Ofp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 10:35:45 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: <linux-kernel@vger.kernel.org>
Subject: Question about Kernel MCE and what exactly they could mean
Date: Thu, 30 Jun 2005 09:38:07 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
thread-index: AcV9gVRjexEyHsHEQWW0BUNLvEmDqg==
Message-ID: <EXCHG2003YKpDS7hx2700000499@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 30 Jun 2005 13:34:27.0498 (UTC) FILETIME=[6FC9F0A0:01C57D78]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have customer that is getting MCE errors, the errors are
non consistantly on a single cpu (this is a opteron system
with separate memory busses),  and the customer believes
that these correspond with the same time he sshes into the
machine from external, they also appear to only be a serious 
issue just after boot up, if the machine survives the first
few sshes, we don't seem to have an issue later, so things
seem to be a early boot up issue of some sort.

The kernel is a Suse 2.4 kernel variant (2.4.21-143), 
I don't expect anyone to likely know if it is a bug.

I have debugged and fixed a large number of machines getting
kernel panic mce errors (by replacing cpu, and if it still 
occurs replacing memory), but I have never seen one being 
started by something like inbound ssh, and have never seen
it move from cpu to cpu with what looks like the same "cause".

The pro's of it being hardware are:
	It gets mce errors.

The pro's of it being software are:
	They aren't consistant on cpu's
	The machine survives heavy HPL runs and does not appear
		to have broken hardware.
	A specific user action seems to cause the issue.

This issue does seem to occur several times a week.

Anyone have any ideas or experience of whether this is a
kernel bug or hardware problem?

                        Roger

