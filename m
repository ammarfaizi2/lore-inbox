Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130779AbQKRBqE>; Fri, 17 Nov 2000 20:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130870AbQKRBpy>; Fri, 17 Nov 2000 20:45:54 -0500
Received: from jalon.able.es ([212.97.163.2]:662 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130783AbQKRBpt>;
	Fri, 17 Nov 2000 20:45:49 -0500
Date: Sat, 18 Nov 2000 02:15:41 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reproducable oops in 2.2.17 and 2.2.18pre21
Message-ID: <20001118021541.A726@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <20001117144938.F12733@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20001117144938.F12733@jaquet.dk>; from rasmus@jaquet.dk on Fri, Nov 17, 2000 at 14:49:38 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2000 14:49:38 Rasmus Andersen wrote:
> Hi.
> 
> I get an oops reproducably with 2.2.17 and 2.2.18pre21 on a stock RH 6.2
> system. I cannot trigger it with the RH supplied kernel (2.2.14-5.0).
> I also got it with 2.2.17pre10 which prompted me to upgrade the kernel.
> I initially suspected bad RAM but have exchanged the RAM with memtest86'ed
> RAM for no improvement.
> 
> What I do: I try to back the system up with tar zcvf /var/backup.tar.gz 
> -X exclude /lib /sbin /var /bin /etc /boot /home /root /usr
> (the exclude file contains the path of the file itself, i.e., 
> /var/ backup.tar.gz).
> 

Exclude /dev and /proc also, /lost+found if you have it, and /mnt if you 
only want that drive. Perhaps things like /proc/kcore make trouble...

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
