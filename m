Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbRDNWQC>; Sat, 14 Apr 2001 18:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbRDNWPx>; Sat, 14 Apr 2001 18:15:53 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:62095 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130900AbRDNWPk>; Sat, 14 Apr 2001 18:15:40 -0400
Message-ID: <3AD8CC04.EA5022C1@coplanar.net>
Date: Sat, 14 Apr 2001 18:15:32 -0400
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: cacook@freedom.net, linux-kernel@vger.kernel.org
Subject: Re: Writing to Pana DVD-RAM
In-Reply-To: <20010414213259Z132548-682+222@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cacook@freedom.net wrote:

> Hello,
>
> I am running RedHat Wolverine (beta) with kernel 2.4.2.  I have a SCSI subsystem (AHA2740) with a Panasonic LF-D101 DVDRAM on it.
>
> I read that the CDROM driver is built to recognize DVDRAMs and allow writes; well I can mount and read the UDF file system fine, but am not allowed writes.  I have UDF2.0 on the disk, because it didn't recognize UDF2.1.
>
> Also, when I  make xconfig,  it includes UDF support, but read-only. (Write-Experimental is grayed-out)
>
> In fstab: /dev/scd1 is mounted to /mnt/dvdram  udf  default 0 0. (paraphrasing)
>
> I need the DVDRAM for backups and file transfers.  Is the problem the driver, the UDF filesystem, my setup, or what?
> --
> C.
>
> The best way out is always through.
>       - Robert Frost  A Servant to Servants, 1914
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Check that "Experimental " is enabled under "Code Maturity level options",
if you can't find it try using "make menuconfig" instead of "make xconfig"
Note that the UDF-write support option is listed as "Dangerous"... possibly
making things difficult, but then again if you have a DVD-RAM,
how bad can things be :)

Cheers,

Jeremy

