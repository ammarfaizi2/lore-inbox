Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286618AbRLUWzy>; Fri, 21 Dec 2001 17:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286619AbRLUWzo>; Fri, 21 Dec 2001 17:55:44 -0500
Received: from [24.83.104.254] ([24.83.104.254]:40840 "EHLO
	whiskey.enposte.net") by vger.kernel.org with ESMTP
	id <S286618AbRLUWzd>; Fri, 21 Dec 2001 17:55:33 -0500
Date: Fri, 21 Dec 2001 14:55:22 -0800
From: Stuart Lynne <sl@fireplug.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Message-ID: <20011221145522.B1940@fireplug.net>
Reply-To: Stuart Lynne <sl@fireplug.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> If you would pay more attention, you can see that on most drives there is
> a small note that says: 1MB = 1000000 bytes. This is why the drive
> capacity is smaller than the manufacturer says.


http://www.seagate.com/products/discsales/discselect/A1a2.html#cap

    Capacity:
    Capacity is the amount of data that the drive can store, after
    formatting. Most disc drive companies, including Seagate, calculate disc
    capacity based on the assumption that 1 megabyte = 1000 kilobytes and 1
    gigabyte=1000 megabytes.


Disks have a natural measurement of capacity based on an integral number
of 512byte blocks. So kilobytes (1024) makes sense for them. 

The only marketing wizardry is to use the smaller of:

	1 megabyte = 1000 kilobytes

instead of:

	1 megabyte = 1024 kilobytes

There are valid arguements for both interpretations. 

-- 
                                            __O 
Lineo - For Embedded Linux Solutions      _-\<,_ 
PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
Stuart Lynne <sl@fireplug.net>         www.lineo.com         604-461-7532
