Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267505AbTAXCYT>; Thu, 23 Jan 2003 21:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267506AbTAXCYS>; Thu, 23 Jan 2003 21:24:18 -0500
Received: from WARSL402PIP6.highway.telekom.at ([195.3.96.93]:21805 "HELO
	email03.aon.at") by vger.kernel.org with SMTP id <S267505AbTAXCYO>;
	Thu, 23 Jan 2003 21:24:14 -0500
Reply-To: <dk@webcluster.at>
From: "Daniel Khan" <dk@webcluster.at>
To: "GrandMasterLee" <masterlee@digitalroadkill.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: AW: AW: 2.4.20 CPU lockup - Now with OOPS message
Date: Fri, 24 Jan 2003 03:33:19 +0100
Message-ID: <DIEGIJEABDDLMLKJFCKJMEFMCEAA.dk@webcluster.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <1043372432.12857.3.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[..]
> I was able to successfully reproduce this error in a test setup, but not
> the crashes. I'm curious if maybe I just start up too many instances of
> rsync and see what happens.
>
> Any particular method or size of files, etc, in reproducing this would
> be greatly beneficial. TIA

Here is the command
/usr/local/bin/nice-rsync --rsync-path=/usr/local/bin/nice-rsync --whole-fil
e -auq --delete /var/log/httpd/ 10.1.0.212:/var/log/httpd

/usr/local/bin/nice-rsync :

#!/bin/sh
  exec nice -n 19 rsync $*

Best regards

Daniel Khan

