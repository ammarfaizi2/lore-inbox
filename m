Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262511AbRFCAyi>; Sat, 2 Jun 2001 20:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbRFCAy2>; Sat, 2 Jun 2001 20:54:28 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:65036 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S262511AbRFCAyN>; Sat, 2 Jun 2001 20:54:13 -0400
Subject: Re: Intellimouse in 2.4.5-ac7
From: Robert Love <rml@tech9.net>
To: mythos <papadako@csd.uoc.gr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0106030331110.28653-100000@iridanos.csd.uch.gr>
In-Reply-To: <Pine.GSO.4.33.0106030331110.28653-100000@iridanos.csd.uch.gr>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10 (Preview Release)
Date: 02 Jun 2001 20:54:16 -0400
Message-Id: <991529658.691.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Jun 2001 03:34:14 +0300, mythos wrote:
> Using kernel 2.4.5-ac7 my intelli is not working at all.
> The kernel doesn't report that it has found it.My config is the same
> with the previous kernel I used 2.4.5-ac2.

can you test it with ac6? ac7 incorpates an incredibly simple patch to
fix poor scrolling in ac4-ac6.  i cant see how this could break
anything.

i am running ac7 right now (and was running ac6 with the patch) and my
IntelliMouse works fine.

I am using the USB HID driver, not the limited mouse-only driver.

[20:48:33]rml@phantasy:~# uname -a
Linux phantasy 2.4.5-ac7 #1 Sat Jun 2 19:38:20 EDT 2001 i686 unknown

[20:49:43]rml@phantasy:~# grep Intelli /var/log/dmesg 
input0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer]
on usb1:2.0

maybe we should stop using microsoft products? :)

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

