Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268674AbRGZVNl>; Thu, 26 Jul 2001 17:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268676AbRGZVNb>; Thu, 26 Jul 2001 17:13:31 -0400
Received: from atlrel1.hp.com ([156.153.255.210]:48634 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S268674AbRGZVNY>;
	Thu, 26 Jul 2001 17:13:24 -0400
Message-ID: <3B60880E.9FBAA76B@fc.hp.com>
Date: Thu, 26 Jul 2001 15:13:50 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Support for serial console on legacy free machines
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I am working on adding support for serial console on legacy free
machines. Legacy free machines are not expected to have the legacy COM
ports. The serial ports on these machines can exist in I/O space, memory
space or they could be PCI devices. This brings up the problem of
detecting where the serial console is. This problem is supposed to be
solved by ACPI 2.0 tables. The table that gives the details of serial
console is "Serial Port Console Redirection" (SPCR) table. This table
gives me almost all the information I need to initialize and use a
serial console. The bummer is this table was designed by Microsoft and
Microsoft owns the copyright on it. Microsoft primarily designed this
table for use by Whistler. Their copyright may cause potential problems
with using it in Linux. This makes me reluctant to use this table. I
would like to know how do others feel about using an ACPI table with
Microsoft copyright. I would like to try to push for another table in
ACPI spec that is free from copyright by any corporation and is simply a
part of spec, if most Linux developers are opposed to using a
copyrighted ACPI table.

Please ask questions if you need more info. URL for SPCR table
definition, if you would like to look at it, is
<http://www.microsoft.com/hwdev/headless/download/SerialPortRedir.zip>.

-- 
Khalid

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
