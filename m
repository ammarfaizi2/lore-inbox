Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271587AbRHUIJK>; Tue, 21 Aug 2001 04:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271592AbRHUIJC>; Tue, 21 Aug 2001 04:09:02 -0400
Received: from ns.roland.net ([65.112.177.35]:30728 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S271587AbRHUIIw>;
	Tue, 21 Aug 2001 04:08:52 -0400
Message-ID: <003401c12a18$d65c4f00$bb1cfa18@JimWS>
From: "Jim Roland" <jroland@roland.net>
To: "Clint Maxwell" <clint_maxwell@yahoo.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <FBEJLMIEKBNCFFPBBGEPMEGPCAAA.clint_maxwell@yahoo.com>
Subject: Re: Kernel suggestion
Date: Tue, 21 Aug 2001 03:11:10 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What software are you trying to use to burn a CD?

Release notes on the XCDRoast website said that since direct ATAPI support
for CDROM drives aren't included anymore (author said there was no point),
to enable ide-scsi for your drives.  I have had to do this to see all of my
drives.  Append this string at your LILO boot prompt (assuming hdc is your
CDRW drive and hdb is your CDROM reader):
    hdb=ide-scsi hdc=ide-scsi

If it works, use it in your append= statement in your /etc/lilo.conf (in the
section for your default linux config).

Regards,
Jim Roland, RHCE

----- Original Message -----
From: "Clint Maxwell" <clint_maxwell@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, August 19, 2001 3:11 AM
Subject: Kernel suggestion


> Hi, I have a suggestion for any upcoming version of the kernel, if you
could
> pass this on to the appropriate people who might be interested in tackling
> this project.  I would like to see, if possible, support for the Philips
> CDD4801 CD-R/RW.  Your work on this would be greatly appreciated.
>
> Sincerely,
> Clint Maxwell
> clint_maxwell@yahoo.com
>
>
> _________________________________________________________
> Do You Yahoo!?
> Get your free @yahoo.com address at http://mail.yahoo.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

