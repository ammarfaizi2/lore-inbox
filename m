Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319222AbSHNEu4>; Wed, 14 Aug 2002 00:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319226AbSHNEu4>; Wed, 14 Aug 2002 00:50:56 -0400
Received: from mail1-0.chcgil.ameritech.net ([206.141.192.68]:52202 "EHLO
	mail1-0.chcgil.ameritech.net") by vger.kernel.org with ESMTP
	id <S319222AbSHNEuz>; Wed, 14 Aug 2002 00:50:55 -0400
Message-ID: <3D59E298.8060604@ameritech.net>
Date: Tue, 13 Aug 2002 23:54:48 -0500
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020613
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Symptoms of overload on Southbridge <-> Northbridge
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This question is not truly a kernel question but it has kernel 
attributes so I decided to ask it here.

I have some measurement situations (using P-3 and P-4) machines where 
the Southbridge to Northbridge connection could get saturated and maybe 
even hit the bandwidth limits.  These machines are usually older 
uni-processor Dells with one flavor or another of Intel chipset.

What sort of hardware symptoms can I expect to see when the bus overloads?

(I am not that worried if the OS crashes but am worried about possible 
hardware damage - heat, out of sequence drive commands etc...)

The machines will have 1 gigabit ethernet taking a full sniffer port 
load from a loaded CISCO 6509 switch and many more 100Mbit ethernets, 
several sniffing and the rest communicating. (Adaptec 4 port units) I 
know that is an insane load but we have hundreds of labs many being near 
idle most of the time.  The mainly near idle labs could use the cheaper 
equipment. It would be nice if there was a way to sense nearing overload 
and dynamically "throttle down". Would any of the /proc provided 
statistics give me the clues I am looking for?

Thanks...



