Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUH1OOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUH1OOi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 10:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUH1OOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 10:14:38 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:51606 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S266308AbUH1OOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 10:14:24 -0400
Message-ID: <4130933D.5060007@blueyonder.co.uk>
Date: Sat, 28 Aug 2004 15:14:21 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.9-rc1-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Aug 2004 14:14:44.0832 (UTC) FILETIME=[5E3A5600:01C48D09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My previous post details the problem with KDE I had on 2.6.9-rc1, 
2.6.9-rc1-mm1 fixed that.
I get hangs with 2.6.9-rc1-mm1 if ACPI or APM are enabled. I haven't 
tried console=ttyS1 to see if there is an oops, but from previous 
experiences also posted, they are probably being generated.
One other problem is that trying to rebuild a 2.6.9-rc1-mm1 kernel under 
2.6.9-rc1-mm1 fails, once as shown below and once elsewhere in fs/. I 
have to boot 2.6.8-rc4-mm1 in order to build 2.6.9-rc1-mm1. Asus A7N8X-E 
nForce2 chipset, Version: ASUS A7N8X-E Deluxe ACPI BIOS Rev 1011, SuSE 
9.1. Upgrading to 1012 shortly.
fs/.tmp_open.o: could not read symbols: File truncated
make[1]: *** [fs/open.o] Error 1
make: *** [fs] Error 2
barrabas:/usr/src/linux-2.6.9-rc1-mm1 # l fs/.tmp_open.o
-rw-r--r--  1 root root 114688 2004-08-27 01:01 fs/.tmp_open.o
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

