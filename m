Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVHYTCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVHYTCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVHYTCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:02:35 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:49938 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932465AbVHYTCd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:02:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050825184551.GA32464@trixie.casa.cgf.cx>
References: <BAY14-F20DDBBC08EC1461957F455BAAB0@phx.gbl> <Pine.LNX.4.61.0508251258330.4160@chaos.analogic.com> <20050825184551.GA32464@trixie.casa.cgf.cx>
X-OriginalArrivalTime: 25 Aug 2005 19:02:32.0736 (UTC) FILETIME=[8C3CE200:01C5A9A7]
Content-class: urn:content-classes:message
Subject: Re: Building the kernel with Cygwin
Date: Thu, 25 Aug 2005 15:01:51 -0400
Message-ID: <Pine.LNX.4.61.0508251500460.5209@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Building the kernel with Cygwin
Thread-Index: AcWpp4xby/lELuT7R5iqOzHy/EQTwQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Christopher Faylor" <me@cgf.cx>
Cc: <linux-kernel@vger.kernel.org>, "Chris du Quesnay" <duquesnay@hotmail.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Aug 2005, Christopher Faylor wrote:

> On Thu, Aug 25, 2005 at 01:05:24PM -0400, linux-os (Dick Johnson) wrote:
>> On Thu, 25 Aug 2005, Chris du Quesnay wrote:
>>> The scripts/basic directory contains a fixdep.exe after the make is
>>> run.  There is no fixdep file.  I tried renaming the fixdep.exe to
>>> fixdep, but that also resulted in the same make error.
>>
>> Ah yes! The Makefile will not execute 'fixdep.exe` it executes 'fixdep'
>> --hard coded.  I don't know how well cygwin emulates a Unix
>> environment, but maybe you can use an alias???  ..  Like...  alias
>> fixdep='fixdep.exe'
>
> How about a symlink?
>
> ln -s fixdep.exe fixdep
>

Maybe I don't know.

I have Cygwin on my laptop, but never put the kernel on it so
I haven't tried.

> cgf
> --
> Christopher Faylor			spammer? ->	aaaspam@sourceware.org
> Cygwin Co-Project Leader				aaaspam@duffek.com
> TimeSys, Inc.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
