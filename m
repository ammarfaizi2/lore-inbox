Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319733AbSIMRaG>; Fri, 13 Sep 2002 13:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319736AbSIMRaG>; Fri, 13 Sep 2002 13:30:06 -0400
Received: from ns1.digital-internetwork.net ([213.186.34.76]:47008 "HELO
	ns1.digital-internetwork.net") by vger.kernel.org with SMTP
	id <S319733AbSIMRaF>; Fri, 13 Sep 2002 13:30:05 -0400
Date: Fri, 13 Sep 2002 12:34:42 -0400
From: Guillaume <guillaume@samizdat.net>
To: linux-kernel@vger.kernel.org
Cc: guillaume@samizdat.net, arjanv@redhat.com, rusty@rustcorp.com.au,
       jgarzik@mandrakesoft.com, goutham.rao@intel.com, visitor@valinux.com
Subject: [2.4.19] new eepro100 driver: "eepro100: wait_for_cmd_done timeout!"
Message-Id: <20020913123442.64b2695e.guillaume@samizdat.net>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; Baron Harkonnen: He who controls the Spice, controls the universe!)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since I upgraded 2.4.18 -> to 2.4.19,
my on-board (VAIO GR) eepro100 ethernet card hangs
when traffic gets above ~10 KB/s. 

   867  Sep 12 22:11:45 thufir kernel: eepro100: wait_for_cmd_done timeout!
   868  Sep 12 22:12:58 thufir last message repeated 8 times
	etc...

I fed the 2.4.18 eepro100 driver to the source tree of .19, recompiled,
and now it works fine again.
Hope it wont be that way on all the future versions.
Just letting you know :)

Besides, great work, I like .19 !

Guillaume

P.S. Please C.C. any reply to my eMail.
 
