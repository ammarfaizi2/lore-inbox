Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTDESka (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 13:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbTDESka (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 13:40:30 -0500
Received: from ns1.enjambre.net ([66.234.10.88]:63932 "HELO ns1.enjambre.net")
	by vger.kernel.org with SMTP id S262598AbTDESk2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 13:40:28 -0500
Message-ID: <3E8DD413.80702@augenopticos.com>
Date: Fri, 04 Apr 2003 10:50:59 -0800
From: Antonio Hernandez <ahernandez@augenopticos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Changing the device between usb printers
References: <3E878F0A.8090709@augenopticos.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the device between usb printers.

I have several usb printers, each have a device to work 
/dev/usb/lp0.../dev/usb/lp1/...etc. an example for the problem. If I 
turn off 2 printers, printer #1 (/dev/usb/lp0)and printer #2 
(/dev/usb/lp1)  if i turn on first printer#2 and later printer #1 I got 
for printer#2 to /dev/usb/lp0 and printer #1 (/dev/usb/lp1), if the 
printers are the same is not a problem but if the printers aren't the 
same then exist a problem  when I send to print. I put a dmesg in 
console and I got messages from "hub.c" that it put the number of 
bus3/3/1 for a printer and bus3/3/2 to another but "printer.c" put 
always usblp0 for the first printer detected and usblp1 to another. I 
think that "printer.c" must to follow the same idea that hub.c to use 
like /dev/usb/bus/3/3/2/lp or something like that

I have a Mandrake 9.0 distribution, I try with the kernel 2.4.20 and 
2.4.21-pre6 too, all have the same problem

Thank you

