Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265874AbRFYEEe>; Mon, 25 Jun 2001 00:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265875AbRFYEEY>; Mon, 25 Jun 2001 00:04:24 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:37138 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S265874AbRFYEEO>; Mon, 25 Jun 2001 00:04:14 -0400
Date: Mon, 25 Jun 2001 00:05:03 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: safemode <safemode@speakeasy.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: cd writer problems with 2.4.5ac17
Message-ID: <Pine.LNX.4.33.0106242352420.1321-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I wrote a CD today under 2.4.5-ac17 on MITSUMI CR-4804TE using SCSI
emulation and cdrecord 1.9. No problems at all.

Another computer is running 2.4.5-ac17 with Promise controller, but I only
have hard drives connected to it. No problems except when ACPI was
enabled.

I understand that your CDR is the first (and maybe the only) device
connected to the Promise controller. Consider connecting it to the onboard
controller if you have one.

What you are describing sounds like a hardware problem. You could try the
old kernel and restore the original confuguration of the system.

If it turns out to be a software problem, I'll appreciate if you locate
the change that caused the problem. Also more details about your hardware
would be useful.

-- 
Regards,
Pavel Roskin

