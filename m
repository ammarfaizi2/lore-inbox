Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317537AbSGVPwc>; Mon, 22 Jul 2002 11:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317546AbSGVPwc>; Mon, 22 Jul 2002 11:52:32 -0400
Received: from virtmail.zianet.com ([216.234.192.37]:31742 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S317537AbSGVPwb>;
	Mon, 22 Jul 2002 11:52:31 -0400
Message-ID: <3D3C2CE9.7030606@zianet.com>
Date: Mon, 22 Jul 2002 10:03:53 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roe Peterson <roe@liveglobalbid.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: raid1 problems in 2.5.26 (maybe started at .1?)
References: <3D3C2773.F33D425@liveglobalbid.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't know if this will help or not but did you see
the massive raid update in 2.5.27?  You may want
to try.

Roe Peterson wrote:

>I'm adding 2.5.26 to a stock redhat 7.3 distribution, which was
>installed with a raid1 root
>filesystem on /dev/hda1 and /dev/hdb1.
>
>This is on a Dell GX-260 w/256MB RAM, twin 20MB IDE hard drives.
>
>The system boots 2.5.26, runs, resyncs the raid1 array, and then, just
>as the resync
>finishes, the BUG at line 655 in drivers/md/raid1.c goes off:
>
>    if (waitqueue_active(&conf->wait_resume)) BUG();
>
>There are no other raid arrays on the system.
>
>I _seriously_ hesitate to simply comment out the bugcheck :-)
>
>
>It seems that the 2.5.1 patch made wholesale changes to the raid1
>subsystem...
>
>Anyone ever seen anything like this?  Have I missed something external
>to the
>kernel that needs to be updated between 2.4.18 and 2.5.26?
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>



