Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130526AbRAZWTY>; Fri, 26 Jan 2001 17:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130695AbRAZWTP>; Fri, 26 Jan 2001 17:19:15 -0500
Received: from [12.8.178.5] ([12.8.178.5]:15432 "EHLO
	huthqhub1.sunglasshut.com") by vger.kernel.org with ESMTP
	id <S130526AbRAZWTG>; Fri, 26 Jan 2001 17:19:06 -0500
Subject: Re: Renaming lost+found
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2c (Intl) 2 February 2000
Message-ID: <OF5807957D.5DF6F45B-ON852569E0.00783722@sunglasshut.com>
From: NDias@sunglasshut.com
Date: Fri, 26 Jan 2001 17:09:59 -0500
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on huthqnmail1/Mail/Servers/SunglassHut(Release 5.0.5 |September
 22, 2000) at 01/26/2001 05:10:31 PM,
	Itemize by SMTP Server on Huthqhub1/Hub/Servers/SunglassHut(Release 5.0.5 |September
 22, 2000) at 01/26/2001 05:26:34 PM,
	Serialize by Router on Huthqhub1/Hub/Servers/SunglassHut(Release 5.0.5 |September
 22, 2000) at 01/26/2001 05:26:42 PM,
	Serialize complete at 01/26/2001 05:26:42 PM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26/01 01:19 PM James Lewis Nance <jlnance@intrex.net> wrote:

>FWIW IBM's JFS file system does not have a lost+found directory.  I dont
>remember if reiserfs does or not.

>Jim

Actually it does.

>From one of my rs/6000's sitting here, with a pretty much default AIX
install:

# uname -a
AIX mon431 3 4 003729474C00
# oslevel
4.3.3.0
# mount
  node       mounted        mounted over    vfs
-------- ---------------  ---------------  ------
         /dev/hd4         /                jfs
         /dev/hd2         /usr             jfs
         /dev/hd9var      /var             jfs
         /dev/hd3         /tmp             jfs
         /dev/hd1         /home            jfs

# find / -name "lost+found"
/lost+found
/var/lost+found
/tmp/lost+found
/home/lost+found
/usr/lost+found

Neal

Any opinions expressed above or below are entirely my own and may not
reflect those of my employers. The information contained in this e-mail
message is confidential, intended only for the receipt and use of the
individual(s) or entity(s) named above. If the reader of this email message
is not the intended recipient, or the employee or agent responsible for its
delivery to the intended and or addressed recipient, you are hereby
notified that any review, dissemination, distribution or copying of this
communication is strictly prohibited except at the express consent of its
author.





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
