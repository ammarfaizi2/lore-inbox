Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbQJaPlX>; Tue, 31 Oct 2000 10:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129470AbQJaPlO>; Tue, 31 Oct 2000 10:41:14 -0500
Received: from mail-gw.fol.uk.net ([193.218.222.20]:45074 "EHLO
	mail-gw.fol.uk.net") by vger.kernel.org with ESMTP
	id <S129286AbQJaPlF>; Tue, 31 Oct 2000 10:41:05 -0500
Message-ID: <06e301c04351$2eadd4d0$1400000a@farmline.com>
From: "Geoff Winkless" <geoff@farmline.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E13qdD3-0007zf-00@the-village.bc.nu>
Subject: Re: 2.2.17 & VM: do_try_to_free_pages failed / eepro100
Date: Tue, 31 Oct 2000 15:42:31 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alan Cox" <alan@lxorguk.ukuu.org.uk> writes:
[about what I wrote]
> > > VM: do_try_to_free_pages failed for httpd...
> > > VM: do_try_to_free_pages failed for httpd...
>
> These if they are odd ones and the box continues are fine, if you get
masses
> of them then probably not

What's it actually doing when this happens? Would it help to allocate more
VM?

> > (our quiet periods) the syslog is nearly empty. In extremis it has been
> > necessary to reboot the machine by kicking the power button.
>
> Are you using software raid ?

No. Should have said it's a Symbios 53c896 SCSI onboard, on an Intel GX
board.

Incidentally I stupidly compiled in support for the onboard sound, which is
the es1371 (rev 8) - don't know if this has any bearing but I'll be taking
it out anyway!

Geoff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
