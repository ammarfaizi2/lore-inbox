Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270134AbRHMMTF>; Mon, 13 Aug 2001 08:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270135AbRHMMSp>; Mon, 13 Aug 2001 08:18:45 -0400
Received: from koppartrans.adm.gu.se ([130.241.20.196]:2432 "HELO
	koppartrans.adm.gu.se") by vger.kernel.org with SMTP
	id <S270134AbRHMMSl>; Mon, 13 Aug 2001 08:18:41 -0400
From: =?ISO-8859-1?Q? "H=E5kan?= Wessberg" <hakan.wessberg@it.gu.se>
Date: Mon, 13 Aug 2001 14:19:36 +0200
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <laughing@shared-source.org>
Subject: Re: Linux 2.4.8-ac2
Message-ID: <20010813141936.A993@it.gu.se>
Mail-Followup-To: =?iso-8859-1?Q?H=E5kan?= Wessberg <hakan.wessberg@it.gu.se>,
	linux-kernel@vger.kernel.org, Alan Cox <laughing@shared-source.org>
In-Reply-To: <20010813002110.A24677@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010813002110.A24677@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[2.4.8-ac2]

This is the situation:
I have a script owned by a non-root user, it's chmod is 700.
as root I can read the content of the file, but I'm not able to execute
the script...

# ls -l touch.sh
-rwx------    1 netsaint root           34 Aug 13 13:37 touch.sh

# ./touch.sh
bash: ./touch.sh: Permission denied

# sh touch.sh
this one works.

To me it looks like as root I have read/write permissions, but not
execute permission.
If I change the permissions from 700 to 755 I can execute the
script with ./touch.sh.

Maybe I'm doing something _really_ wrong here.


Cheers Nacka

