Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbTCCLaf>; Mon, 3 Mar 2003 06:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbTCCLaf>; Mon, 3 Mar 2003 06:30:35 -0500
Received: from mail.ithnet.com ([217.64.64.8]:63248 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S264646AbTCCLae>;
	Mon, 3 Mar 2003 06:30:34 -0500
Date: Mon, 3 Mar 2003 12:40:51 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: freesoftwaredeveloper@web.de, hanasaki@hanaden.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.20 ide-scsi
Message-Id: <20030303124051.5f60ba99.skraw@ithnet.com>
In-Reply-To: <3E6261C3.1020700@pobox.com>
References: <3E625282.8010101@hanaden.com>
	<200303022038.53606.freesoftwaredeveloper@web.de>
	<3E6261C3.1020700@pobox.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Mar 2003 14:55:47 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Michael Buesch wrote:
> >>CONFIG_BLK_DEV_IDECD=y
> > 
> > 
> > seems, that you have made the same mistake like me yesterday.
> > (Thanks to Brian Davis again)
> > 
> > Just disable CONFIG_BLK_DEV_IDECD and try if it works.
> 
> 
> The standard solution, supported by all major distributions, is to supply
> 	hdX=ide-scsi
> on the kernel command line.
> 
> There is no need to completely disable IDE-CD.  IDE-CD and IDE-SCSI can 
> and do interoperate all the time.
> 
> 	Jeff

Any ideas why mounting reproducably oopses my machine under
2.4.21-pre4/pre5[-acX] ? See [OOPS in 2.4.21-pre5, ide-scsi] topic...

-- 
Regards,
Stephan
