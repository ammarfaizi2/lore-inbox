Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280361AbRK1Tk3>; Wed, 28 Nov 2001 14:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280434AbRK1TkU>; Wed, 28 Nov 2001 14:40:20 -0500
Received: from smtp02.web.de ([217.72.192.151]:56585 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S280361AbRK1TkH> convert rfc822-to-8bit;
	Wed, 28 Nov 2001 14:40:07 -0500
From: "Matthias Benkmann" <haferfrost@web.de>
To: linux-kernel@vger.kernel.org
Date: Wed, 28 Nov 2001 20:40:02 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Subject: Re: sym53c875: reading /proc causes SCSI parity error
Message-ID: <3C054BA2.9822.8DFF90@localhost>
In-Reply-To: <3C053AF2.10037.4CCE47@localhost>
In-Reply-To: <xltelmiso7t.fsf@shookay.e-steel.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Nov 2001, at 14:13, Mathieu Chouquet-Stringer wrote:

> I bet it only happens when you're root and you read /proc/scsi/sym53c8xx/0
> (or whatever in your case).
> 
> I had this discussion with Gérard Roudier and it's not a bug, rather a
> feature...

Care to elaborate? What happens when you read that file? And why does it 
cause an error even when the disk is not currently being accessed? As I 
said there can be considerable time between running my script and 
accessing the disk. And why do I get different errors depending on whether 
I access the disk before I run the script or run the script before I 
access the disk?

MSB

----
Who is this General Failure,
and why is he reading my disk ?

