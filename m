Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130662AbRCEU7d>; Mon, 5 Mar 2001 15:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130663AbRCEU7X>; Mon, 5 Mar 2001 15:59:23 -0500
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:21444 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S130662AbRCEU7I>; Mon, 5 Mar 2001 15:59:08 -0500
To: linux-kernel@vger.kernel.org
From: Trevor-Hemsley@dial.pipex.com (Trevor Hemsley)
Date: Mon, 05 Mar 2001 20:11:17
Subject: Re: 2.4.2 broke in-kernel ide_cs support
X-Mailer: ProNews/2 V1.51.ib103
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010305205914Z130662-407+1559@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001 08:14:42, Pavel Machek <pavel@suse.cz> wrote:

> 
> I do not yet know details, but it worked in 2.4.1 and it does not work
> now:
>  
> Mar  5 09:12:05 bug cardmgr[69]: initializing socket 1
> Mar  5 09:12:05 bug cardmgr[69]: socket 1: ATA/IDE Fixed Disk
> Mar  5 09:12:05 bug cardmgr[69]: module //pcmcia/ide_cs.o not
> available
> Mar  5 09:12:06 bug cardmgr[69]: get dev info on socket 1 failed:
> Resource temporarily unavailable
>                                                                 Pavel
> ((Module not available is okay, it should be compiled into kernel))

/etc/pcmcia/config refers to ide_cs but module is ide-cs. I've edited 
/etc/pcmcia/config and changed all ide_cs to ide-cs and it works.

-- 
Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com
