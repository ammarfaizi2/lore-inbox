Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311262AbSDIUPM>; Tue, 9 Apr 2002 16:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311264AbSDIUPM>; Tue, 9 Apr 2002 16:15:12 -0400
Received: from [209.249.147.146] ([209.249.147.146]:23300 "EHLO
	addr-mx02.addr.com") by vger.kernel.org with ESMTP
	id <S311262AbSDIUPL>; Tue, 9 Apr 2002 16:15:11 -0400
Date: Tue, 9 Apr 2002 16:14:12 -0400
From: Daniel Gryniewicz <dang@fprintf.net>
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan S2462 reboot problems
Message-Id: <20020409161412.777aec9a.dang@fprintf.net>
In-Reply-To: <200204091917.g39JHpe15914@athlon.cichlid.com>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

No, I doubt this has anything to do with Linux.   I have a S2460 (which his
corrected post says he has), which does not power down under linux, and
*never* warm boots cleanly.  It does power down under windows, so I assume
ACPI powerdown works and APM does not.  I have gone under the assumption that
a BIOS upgrade will fix this, but that involves putting a floppy into the box,
so I haven't done it yet.  The warm boot problems consist of either a hang
after POST (but before bootloader, OS irrelevent), or really bad video
corruption.  I don't know if it boot with the video corruption, I've never let
it try.

Daniel

On Tue, 9 Apr 2002 12:17:51 -0700
Andrew Burgess <aab@cichlid.com> wrote:

> 
> > what (which config option) could be the reason for a reboot hang on a
> >S2462 (2x1900MP, 2GB, BIOS 2.09) between POST/BIOS and LILO?
> 
> You don't say what kind of disk controllers but 2.4.18 was broken with
> respect to error handling and Promise IDE controllers. I have one flakey
disk> that would reboot a new machine after a few minutes activity. 2.4.19pre6
just> prints an error message, retrys and gos merrily on it way.
> 
> So if you have Promise chips maybe try switching boot drives?
> 
> HTH
> 
> Andrew Burgess
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary

