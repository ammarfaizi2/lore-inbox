Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132441AbRA0Jyp>; Sat, 27 Jan 2001 04:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132447AbRA0Jyf>; Sat, 27 Jan 2001 04:54:35 -0500
Received: from Huntington-Beach.blue-labs.org ([208.179.0.198]:554 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S132441AbRA0Jy0>; Sat, 27 Jan 2001 04:54:26 -0500
Message-ID: <3A729AC6.36B2A616@linux.com>
Date: Sat, 27 Jan 2001 09:54:14 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <Shawn.Starr@Home.com>
CC: mlord@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM]: Under 2.4.X hdparm displays device names backwards? ;)
In-Reply-To: <3A7296E1.43DDF06A@Home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-I is what is read directly off the drive, -i interprets it.  IIRC, it's been
this way for a while..or it's just that I've used 2.4 for a while :)  In any
case, it's byte swap issue.  WD becomes "WDC AC" would become "DW CCA" , i.e.
"WD",  "C ", and "AC" etc.

-d

Shawn Starr wrote:

> This is what the device names are:
>
> hda: FUJITSU MPE3064AT, ATA DISK drive
> hdb: WDC AC32500H, ATA DISK drive
>
> here's what they are with hdparm:
>
> dev/hda:
>
>  Model=UFIJST UPM3E60A4 T                      , FwRev=DE0--380,
> SerialNo=            50256499
>
> /dev/hdb:
>
>  Model=DW CCA2305H0                            , FwRev=210.H721,
> SerialNo=DWW-3T06418895 2
>
> hehe, might wanna fix that ;-)
>
> Shawn.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
