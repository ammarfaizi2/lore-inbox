Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272158AbRIOIcY>; Sat, 15 Sep 2001 04:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272195AbRIOIcP>; Sat, 15 Sep 2001 04:32:15 -0400
Received: from pD900DE6D.dip.t-dialin.net ([217.0.222.109]:46887 "EHLO
	bennew01.localdomain") by vger.kernel.org with ESMTP
	id <S272158AbRIOIcF>; Sat, 15 Sep 2001 04:32:05 -0400
Date: Sat, 15 Sep 2001 10:32:55 +0200
From: Matthias Haase <matthias_haase@bennewitz.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@zip.com.au>
Subject: repeatable SMP lockups - kernel 2.4.9
Message-Id: <20010915103255.5e4cce12.matthias_haase@bennewitz.com>
In-Reply-To: <3BA24E85.C92FA693@zip.com.au>
In-Reply-To: <20010914143021.0a5c9791.matthias_haase@bennewitz.com>
	<3BA24E85.C92FA693@zip.com.au>
X-Operating-System: linux smp kernel 2.4* on i686
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew...

> Have you tried enabling the NMI watchdog?  Boot with the
> 
> 	nmi_watchdog=1
> 
> LILO option.

Have this tried today, but no debugging messages is printed out.
The cursor blinks, and if the hang comes up, blinking is frozen.
Have nmi_watchdog=1 set in lilo.conf +  # /etc/lilo -v -v 
No watchdog or software-watchdog is compiled in the kernel, but I think,
this isn't related to the nmi_watchdog? 

Thank's for your help.

regards

                           Matthias

-- 
Gruesse


Matthias Haase            | Telefon +49-(0)3733-23713
Markt 2                   | Telefax +49-(0)3733-22660
                          |
D-09456 Annaberg-Buchholz | http://www.bennewitz.com
