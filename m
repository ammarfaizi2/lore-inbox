Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292868AbSB0UtY>; Wed, 27 Feb 2002 15:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292942AbSB0UtE>; Wed, 27 Feb 2002 15:49:04 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:54026 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S292940AbSB0UsW>; Wed, 27 Feb 2002 15:48:22 -0500
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 27 Feb 2002 21:49:51 +0100
From: Andreas Roedl <flood@flood-net.de>
In-Reply-To: <20020227111008.A13182@sonic.net>
Message-Id: <20020227204649.92C08AA40@flood-net.de>
MIME-Version: 1.0
Organization: Flood-Net
In-Reply-To: <20020227111008.A13182@sonic.net>
Subject: Re: pcmcia problems with IDE & cardbus
To: dhinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
X-AntiVirus: OK! AvMailGate Version 6.11.0.5
	 at exciter has not found any known virus in this email.
X-Mailer: KMail [version 1.3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Am Mittwoch, 27. Februar 2002 20:10 schrieb dhinds:
> Andreas Roedl wrote:
> > Apart from your problem I finally found out that all dldwd_* stuff in
> > 2.4.18 has been renamed to orinoco_*, so pcmcia-3.1.31 is not usable with
> > 2.4.18...
>
> Err what?

/lib/modules/2.4.18/pcmcia/orinoco_cs.o: unresolved symbol dldwd_proc_dev_init
/lib/modules/2.4.18/pcmcia/orinoco_cs.o: unresolved symbol dldwd_setup
/lib/modules/2.4.18/pcmcia/orinoco_cs.o: unresolved symbol dldwd_shutdown
/lib/modules/2.4.18/pcmcia/orinoco_cs.o: unresolved symbol 
dldwd_proc_dev_cleanup
/lib/modules/2.4.18/pcmcia/orinoco_cs.o: unresolved symbol dldwd_reset
/lib/modules/2.4.18/pcmcia/orinoco_cs.o: unresolved symbol dldwd_interrupt
/lib/modules/2.4.18/pcmcia/orinoco_cs.o: insmod 
/lib/modules/2.4.18/pcmcia/orinoco_cs.o failed
/lib/modules/2.4.18/pcmcia/orinoco_cs.o: insmod orinoco_cs failed

?


Andi

-- 
Web:   http://www.flood-net.de/
Mail:  flood@flood-net.de
Phone: +49-(0)-30-680577-44
Linux opens doors, not windows!
http://www.bundestux.de/   http://counter.li.org/
