Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWBPOfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWBPOfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 09:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWBPOfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 09:35:17 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:55567 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932526AbWBPOfP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 09:35:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060216142556.GC5939@stiffy.osknowledge.org>
X-OriginalArrivalTime: 16 Feb 2006 14:35:13.0754 (UTC) FILETIME=[328CB3A0:01C63306]
Content-class: urn:content-classes:message
Subject: Re: Linux-2.6.15.4 login errors
Date: Thu, 16 Feb 2006 09:35:13 -0500
Message-ID: <Pine.LNX.4.61.0602160934230.22192@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux-2.6.15.4 login errors
thread-index: AcYzBjKwvUuxwKoNScu/gTzVyR1fNA==
References: <Pine.LNX.4.61.0602160859380.4753@chaos.analogic.com> <20060216142556.GC5939@stiffy.osknowledge.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Marc Koschewski" <marc@osknowledge.org>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2006, Marc Koschewski wrote:

> * linux-os (Dick Johnson) <linux-os@analogic.com> [2006-02-16 09:13:46 -0500]:
>
>>
>>
>> After installing linux-2.6.15.4, attempts to log in a non-root
>> account gives these errors.
>>
>> Password:
>> Last login: Thu Feb 16 08:53:20 on tty1
>> Keymap 0: Permission denied
>> Keymap 1: Permission denied
>> Keymap 2: Permission denied
>> LDSKBENT: Operation not permitted
>> loadkeys: could not deallocate keymap 3
>>
>> I have searched /etc/profile, /etc/bashrc, all the scripts in
>> /etc/profile.d. I can't find where loadkeys is even executed!
>>
>> This is a RH Fedora base. Anybody know how to turn this crap off?
>>
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.6.15.4 on an i686 machine (5590.48 BogoMips).
>> Warning : 98.36% of all statistics are fiction.
>> _
>> 
>
> vi .profile .bashrc .bash_profile in the user's ~/ ?
>
> The executed binary should be 'loadkeys'. Try 'loadkeys -s' as a user and see
> the output on the console. Should be your quite your error messages...
>
> Marc


Thanks. I found where it was executed from and hacked a temp
fix to quiet it down.



Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5590.48 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
