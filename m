Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132847AbRDIVKm>; Mon, 9 Apr 2001 17:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132850AbRDIVKc>; Mon, 9 Apr 2001 17:10:32 -0400
Received: from isis.telemach.net ([213.143.65.10]:23815 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S132847AbRDIVKY>;
	Mon, 9 Apr 2001 17:10:24 -0400
Message-ID: <3AD2253E.2DA0895A@telemach.net>
Date: Mon, 09 Apr 2001 23:10:22 +0200
From: Jure Pecar <pegasus@telemach.net>
Organization: Select Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx and 2.4.3 failures
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can add a "me too" to this thread.

I began playing with 2.4 releases (again) at 2.4.2-ac23 and i can't
manage to boot it properly, even the 2.4.3-ac2. I have an adaptec 2940U
(aic7860 as driver tells me) and both drivers, old and new, dont work
properly. Either i get request_module[scsi_hostadapter]: Root fs not
mounted, and then what seems to be a random oops a couple of seconds
later in the beginning of the init scripts, or, root fs doesnt get
remounted rw, which is followed soon by some oopsen. I reported one back
then (
http://boudicca.tux.org/hypermail/linux-kernel/2001week13/0077.html ).

Looks weird ... have there been any changes around aic driver recently?
I can try to write down some more oopsen if anyone is interested ... 

On the other side, 2.2.19 with new aic driver 6.1.10 is working just
nice ... 


-- 


Jure Pecar
