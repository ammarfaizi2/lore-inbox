Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292332AbSBBSQw>; Sat, 2 Feb 2002 13:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292336AbSBBSQn>; Sat, 2 Feb 2002 13:16:43 -0500
Received: from relay-4v.club-internet.fr ([194.158.96.115]:16588 "HELO
	relay-4v.club-internet.fr") by vger.kernel.org with SMTP
	id <S292332AbSBBSQ0>; Sat, 2 Feb 2002 13:16:26 -0500
Message-ID: <3C5C2D8F.2050003@freesurf.fr>
Date: Sat, 02 Feb 2002 19:18:55 +0100
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020201
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 512 Mb DIMM not detected by the BIOS!
In-Reply-To: <3C5C7C66.1050007@cucumelo.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benny Sjostrand wrote:
> Hello everyone!

Hello

> so my question to you "kernel-gurus", is there any posibility
 > to configure the Linux kernel to bypass the BIOS and actually
 > use my 512MB ?

You don't need to be a "kernel-guru" to answer this question.
The list of kernel boot parameters is in
linux/Documentation/kernel-parameters.txt
There, you can find:

  mem=nn[KMG]     [KNL,BOOT] force use of a specific amount of
                  memory; to be used when the kernel is not able
                  to see the whole system memory or for test.

So append mem=512M in your kernel command line. If you use lilo add
append = "mem=512M" in your lilo.conf file (and rerun lilo).

-- 
** Gael Le Mignot "Kilobug", Ing3 EPITA - http://kilobug.free.fr **
Home Mail   : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

"Software is like sex it's better when it's free.", Linus Torvalds

