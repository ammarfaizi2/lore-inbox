Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbRF2VlZ>; Fri, 29 Jun 2001 17:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261562AbRF2VlP>; Fri, 29 Jun 2001 17:41:15 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35728 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261558AbRF2VlK>;
	Fri, 29 Jun 2001 17:41:10 -0400
Message-ID: <3B3CF618.DDE40F17@mandrakesoft.com>
Date: Fri, 29 Jun 2001 17:41:44 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dmitry Meshchaninov <dima@flash.datafoundation.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, cwl@iol.unh.edu,
        Denis Gerasimov <denis@datafoundation.com>
Subject: Re: qlogicfc driver
In-Reply-To: <Pine.LNX.4.30.0106291714470.11344-100000@flash.datafoundation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Meshchaninov wrote:
> 
>   Hi!
>   Judging from recent messages on linux-kernel and from the code which is
> currently in 2.4.x the qlogicfc driver needs to be updated a bit. I have
> done some amount of work on this driver and have sent patches to
> Chris in the past, however I did not receive any comments on my changes.
> It looks like Chris is too busy with other things right now, and I will
> gladly maintain the driver if there is a consensus that the driver needs
> a new maintainer. Meanwhile I am cleaning up driver for 2.4.4
> (not tested with 2.4.5 yet, but probably will work). I'll publish those
> changes if there will be any interest.  It is a  drop-in replacement for
> the five files in drivers/scsi/ (qlogicfc.c, qlogicfc.h, qlogicfc_inc.h,
> qlogicfc_asm_ip.c and qlogicfc_asm.c).  This contains updated (both with
> and without ip support) firmware and many bugfixes. I decided not to
> provide a patch because it is bigger then just those five files combind.
> I have splitted up driver body into .h-file with types&defines  and
> driver itself (as it should be). But this is negotiable.

If you are working on qlogicfc, that's great!

But since others are currently using this driver without problems, you
might consider sending in your patches separated out (per
Documentation/SubmittingPatches) so that it is easier for others to
review and apply them in turn.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
