Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267485AbTAXAC5>; Thu, 23 Jan 2003 19:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbTAXAC4>; Thu, 23 Jan 2003 19:02:56 -0500
Received: from WARSL402PIP3.highway.telekom.at ([195.3.96.97]:33104 "HELO
	email01.aon.at") by vger.kernel.org with SMTP id <S267485AbTAXACx>;
	Thu, 23 Jan 2003 19:02:53 -0500
Reply-To: <dk@webcluster.at>
From: "Daniel Khan" <dk@webcluster.at>
To: "GrandMasterLee" <masterlee@digitalroadkill.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: AW: 2.4.20 CPU lockup - Now with OOPS message
Date: Fri, 24 Jan 2003 01:11:59 +0100
Message-ID: <DIEGIJEABDDLMLKJFCKJCEFLCEAA.dk@webcluster.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1043366749.28748.124.camel@UberGeek>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I reported frequently system lockups today.
> > Now after some playing around (cause I don't know anything about kernel
> > debugging - Thanks to Mark Hahn for the tipps)
> > I found a way to reproduce the lock and to get the OOPS.
[..]

> Can I ask how you reproduced this? I've got several systems with TG3's
> and they only get lockups during network backups.

httpd session on the host which has big logfiles to get them changed.
Starting rsync to sync the logfiles and other stuff to the backup host.

Sometimes I have to retry 2-3 times but it crashes very reliable.
It's quite the same as the network backups you mentioning.

Daniel Khan
