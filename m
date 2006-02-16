Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWBPOd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWBPOd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 09:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWBPOd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 09:33:26 -0500
Received: from spirit.analogic.com ([204.178.40.4]:25872 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932524AbWBPOdZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 09:33:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060216142824.GD13188@redhat.com>
X-OriginalArrivalTime: 16 Feb 2006 14:33:24.0348 (UTC) FILETIME=[F156ABC0:01C63305]
Content-class: urn:content-classes:message
Subject: Re: Linux-2.6.15.4 login errors
Date: Thu, 16 Feb 2006 09:33:24 -0500
Message-ID: <Pine.LNX.4.61.0602160930360.22192@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux-2.6.15.4 login errors
thread-index: AcYzBfF8t5pE+/btSBOa2lF9BiN1ug==
References: <Pine.LNX.4.61.0602160859380.4753@chaos.analogic.com> <20060216142824.GD13188@redhat.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Dave Jones" <davej@redhat.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2006, Dave Jones wrote:

> On Thu, Feb 16, 2006 at 09:13:46AM -0500, linux-os (Dick Johnson) wrote:
> >
> >
> > After installing linux-2.6.15.4, attempts to log in a non-root
> > account gives these errors.
> >
> > Password:
> > Last login: Thu Feb 16 08:53:20 on tty1
> > Keymap 0: Permission denied
> > Keymap 1: Permission denied
> > Keymap 2: Permission denied
> > LDSKBENT: Operation not permitted
> > loadkeys: could not deallocate keymap 3
> >
> > I have searched /etc/profile, /etc/bashrc, all the scripts in
> > /etc/profile.d. I can't find where loadkeys is even executed!
>
> It's coming from unicode_start
>
> > This is a RH Fedora base. Anybody know how to turn this crap off?
>
> Apply updates.
> This was fixed in kbd 1.12-10.fc4.1
>
> 		Dave

Okay. Thanks. Right now I found loadkeys being executed in
/bin/unicode_start. I just temporarily commented it out.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5590.48 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
