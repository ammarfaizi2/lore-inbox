Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264650AbSIWBEG>; Sun, 22 Sep 2002 21:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264651AbSIWBEG>; Sun, 22 Sep 2002 21:04:06 -0400
Received: from lakemtao08.cox.net ([68.1.17.113]:12180 "EHLO
	lakemtao08.cox.net") by vger.kernel.org with ESMTP
	id <S264650AbSIWBEG>; Sun, 22 Sep 2002 21:04:06 -0400
Message-ID: <000901c2629d$d16d8b80$0a01a8c0@central.cox.net>
From: "Seth Z. Dickerson" <szdickerson@cox.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: DMA finally works! Thanks!
Date: Sun, 22 Sep 2002 20:09:07 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 2002-09-17 at 5:48 Alan Cox Wrote:
>On Tue, 2002-09-17 at 08:48, Andre Hedrick wrote:
>> On Tue, 17 Sep 2002, Rob Speer wrote:
>>
>> > Now that I'm using -pre7, DMA finally works on my Intel 845G controller
>> > that was being such a pain in the ass.
>> >
>> > Someone out there, possibly Andre, rules. Great work.
>>
>> I did not touch -pre7 directly, maybe Alan Cox filtered some goodies.
>
>
>I  filtered out the PCI changes and the pci_enable_bars code. So its my
>work, but Andre's explanations about what we should be doing

Just an fyi, with -pre7 the onboard IDE controller works, but the onboard
audio driver  (810-compatible) does not.
With -p437-ac3 the 845G's IDE controller is broken again (no more DMA), but
the onboard audio (810-compatible) is fixed.


