Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129551AbQJaQlZ>; Tue, 31 Oct 2000 11:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbQJaQlP>; Tue, 31 Oct 2000 11:41:15 -0500
Received: from proxy.ovh.net ([213.244.20.42]:56836 "HELO proxy.ovh.net")
	by vger.kernel.org with SMTP id <S129551AbQJaQk5>;
	Tue, 31 Oct 2000 11:40:57 -0500
Message-ID: <39FEF603.7F6950AF@ovh.net>
Date: Tue, 31 Oct 2000 17:40:35 +0100
From: octave klaba <oles@ovh.net>
X-Mailer: Mozilla 4.73 [en] (Win98; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: Geoff Winkless <geoff@farmline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.17 & VM: do_try_to_free_pages failed / eepro100
In-Reply-To: <069c01c0434b$ad0c5a50$1400000a@farmline.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oct 31 12:12:25 mail-client kernel: VM: do_try_to_free_pages failed for
> sendmail
> ...
> Oct 31 12:12:26 mail-client last message repeated 60 times
> Oct 31 12:12:26 mail-client kernel: VM: do_try_to_free_pages failed for
> kupdate.
>
> To agree with Octave, this only appears to happen under load - over weekends
> (our quiet periods) the syslog is nearly empty. In extremis it has been
> necessary to reboot the machine by kicking the power button.

on our servers it arrived only when the swap is used. for exemple:
there is too many requests on the web server, machine begins to swap,
after 3-4 minutes we have the first VM errors. it is too late. 
the solutions: reboot server / unplug cable / cut port 80 on the router 
and wait ... after 3-4 minutes server rebegins to work finely. If you do 
not touch the swap you have never this problem. another solution is to 
put lot of ram ;) 

Octave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
