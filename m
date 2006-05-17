Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWEQPbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWEQPbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWEQPbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:31:01 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:21259 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750722AbWEQPbB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:31:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 17 May 2006 15:30:52.0979 (UTC) FILETIME=[E20F8030:01C679C6]
Content-class: urn:content-classes:message
Subject: Re: replacing X Window System !
Date: Wed, 17 May 2006 11:30:46 -0400
Message-ID: <Pine.LNX.4.61.0605171129570.31662@chaos.analogic.com>
In-Reply-To: <200605171514.k4HFEPKq020058@turing-police.cc.vt.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: replacing X Window System !
Thread-Index: AcZ5xuIZXjW9JpXIThCykwxTOBr3XA==
References: <20060517145335.36079.qmail@web26611.mail.ukl.yahoo.com>            <200605171509.k4HF9dPR019875@turing-police.cc.vt.edu> <200605171514.k4HFEPKq020058@turing-police.cc.vt.edu>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <Valdis.Kletnieks@vt.edu>
Cc: "linux cbon" <linuxcbon@yahoo.fr>, "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 May 2006 Valdis.Kletnieks@vt.edu wrote:

> On Wed, 17 May 2006 11:09:38 EDT, Valdis.Kletnieks@vt.edu said:
>
>> Totalling it up:
>> 11984127 359976   85608 12429711
>>
>> Yowza.  124 *meg*.
>
> 12.4 (slipped a decimal pint). But still.
>
>>> But that would greatly simplify the whole system.
>
>> Yeah, adding 124 meg to a 4.2M kernel will simplify it...
>
> Still quadruples the size and even worse on complexity...
>


The X window system was an excellent design
that just isn't used properly if you really
need a high security environment. All you
need is a "display machine" that runs X.
The high-security machine doesn't run X,
it just runs the X-Window programs after
setting the proper DISPLAY environment string.
The I/O for these programs will run over
the network to your display machine. The
network can be a dedicated wire from dedicated
controllers if you are all freaked out about
security.

The combination of a display machine with
nothing important on it, plus the connected
high-security machine makes for a no-compromise
situation, but certainly more expensive than
running a single machine.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.AbominableFirebug.com/ http://www.LymanSchool.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
