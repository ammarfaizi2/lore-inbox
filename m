Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269257AbUJFMyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269257AbUJFMyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 08:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269255AbUJFMyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 08:54:53 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:13210 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S269010AbUJFMyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 08:54:52 -0400
Message-ID: <010e01c4abab$e90da780$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "Ulrich Drepper" <drepper@redhat.com>,
       "Christoph Lameter" <clameter@sgi.com>
Cc: "George Anzinger" <george@mvista.com>, <johnstul@us.ibm.com>,
       <Ulrich.Windl@rz.uni-regensburg.de>, <jbarnes@sgi.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <libc-alpha@sources.redhat.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com> <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com> <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com> <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com> <415AF4C3.1040808@mvista.com> <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0410011259190.18738@schroedinger.engr.sgi.com> <415E3D5A.2010501@redhat.com>
Subject: Re: Posix compliant cpu clocks V6 [2/3]: Glibc patch
Date: Wed, 6 Oct 2004 14:53:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ulrich Drepper" <drepper@redhat.com>
> Christoph Lameter wrote:
>> The following patch makes glibc not provide the above clocks and use the
>> kernel clocks instead if either of the following condition is met:
>
> Did you ever hear about a concept called binary compatiblity?  Don't
> bother working on any glibc patch.

The functionality should arguably not have been added to glibc in the first
place since its implementation was incorrect.

--ms


