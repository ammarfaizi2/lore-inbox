Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVA0Xxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVA0Xxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVA0Xv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:51:57 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:48056 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261318AbVA0Xk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:40:29 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: i8042 access timings
Date: Thu, 27 Jan 2005 18:40:24 -0500
User-Agent: KMail/1.7.2
Cc: Jaco Kroon <jaco@kroon.co.za>, sebekpi@poczta.onet.pl,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F96743.9060903@kroon.co.za> <Pine.LNX.4.58.0501271426420.2362@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501271426420.2362@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501271840.24522.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 January 2005 17:36, Linus Torvalds wrote:
> > I also tried increasing the total timeout value to about 5 seconds 
> > (versus the default half second), still no success, so the device is 
> > simply not sending back the requested values.
> 
> If it was the other way around (that it works with ACPI _on_), I'd assume 
> that ACPI just disables some broken BIOS SMM emulation code. But I just 
> don't see ACPI _enabling_ SMM emulation. That would be just too strange, 
> and against the whole point of the legacy keyboard emulation stuff - you 
> want to do legacy keyboard emulation if the OS is old, not if it's new.

It is my understanding that ACPI and legacy emulation are to a certain
degree tangent to each other. You can work in ACPI mode and still use USB
legacy emulation and you could be in legacy mode but with USB loaded and
USB legacy emulation turned off.
 
-- 
Dmitry
