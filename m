Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281794AbRKVWC1>; Thu, 22 Nov 2001 17:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281796AbRKVWCT>; Thu, 22 Nov 2001 17:02:19 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:12205 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S281794AbRKVWCJ>; Thu, 22 Nov 2001 17:02:09 -0500
Message-ID: <3BFD769A.376003D5@nortelnetworks.com>
Date: Thu, 22 Nov 2001 17:05:14 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.15-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problem accessing /dev/port
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To begin, I'm running 2.2.17 with some patches.

I'm attempting to have a userspace app read and write I/O ports on a powerpc
machine.  The obvious method (iopl()) doesn't seem to be available (using glibc,
but sys/io.h doesn't exist).

When I try and access /dev/port with a small utility that works fine on my PIII,
I get the error message "Device not configured".  The file exists in /dev and
has the same permissions on both machines.

Do I need to enable something in the kernel to support this?  Where is this
configured?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
