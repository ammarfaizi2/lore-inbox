Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264721AbUEKNlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264721AbUEKNlJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 09:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264724AbUEKNlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 09:41:08 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:18077 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S264721AbUEKNlE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 09:41:04 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-11.tower-45.messagelabs.com!1084282858!2884706
X-StarScan-Version: 5.2.10; banners=-,-,-
X-Originating-IP: [141.156.156.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: weird clock problem
Date: Tue, 11 May 2004 09:40:40 -0400
Message-ID: <5D3C2276FD64424297729EB733ED1F7605E28AF2@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: weird clock problem
Thread-Index: AcQ3XFkL90VLBfEPSLWwYMW6ejEijgAAO0IA
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: <nelis@brabys.co.za>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also have the same problem running Linux 2.6.5 under VMWARE (latest)
for WindowsXP.

If I do not sync every five minutes, the begins to drift a lot!

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Nelis Lamprecht
Sent: Tuesday, May 11, 2004 9:30 AM
To: linux-kernel@vger.kernel.org
Subject: weird clock problem

Hi,

Over the past few weeks I've been having major problems keeping time on
my machine with kernel 2.6.5. At first I thought it was a problem with
ntpd but as it turns out it's my kernel.

The problem became evident while copying vast amounts of data across to
my machine. While I was copying data to it via scp my random
Xscreensaver kicked in displaying the clock and the first thing I
noticed was that the clock was advancing at a rapid rate. At the same
time I could not type anything as it would just repeat everything I
typed 10 fold. Basically the whole system behaved like it was on
steroids while I was copying to it and by the time I had finished
copying the clock was 2hrs ahead of time. With kernel 2.6.5 ntpd would
work on startup and then die saying no servers could be reached which I
assume was because my clock was so far off.

I have since downgraded to 2.6.3 and now ntpd is keeping time as it
should.

Anybody else come across this behaviour ? I'm running Gentoo on an IBM
ThinkCentre P4 3ghz. I also have APM enabled in both kernels.

Cheers,
Nelis

ps. Please CC me in on your reply as I am not subscribed.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


