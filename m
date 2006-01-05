Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWAELXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWAELXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWAELXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:23:51 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:11436 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S932389AbWAELXv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:23:51 -0500
Content-Disposition: inline
From: =?iso-8859-1?q?Jo=E3o_Esteves?= <joao.m.esteves@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: Via VT 6410 Raid Controller
Date: Thu, 5 Jan 2006 11:23:54 +0000
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200601051123.54066.joao.m.esteves@netcabo.pt>
X-OriginalArrivalTime: 05 Jan 2006 11:23:49.0439 (UTC) FILETIME=[8003CCF0:01C611EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----------  Mensagem Reencaminhada  ----------

Subject: Re: Via VT 6410 Raid Controller
Date: Quinta, 5 de Janeiro de 2006 11:12
From: João Esteves <joao.m.esteves@netcabo.pt>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hello:

I was finally able to install the patch. I have now the Pata HDD as drive
 hdg. Thank you, Daniel and Bartlomiej.

João

> On 1/3/06, João Esteves <joao.m.esteves@netcabo.pt> wrote:
> > Thank you, Daniel.
> >
> > > Can you explain what you mean by you don't "see" it? Where are you
> > > looking?
> > >
> > > You could also post the output of:
> > >       dmesg
> > >       lspci
> > >       lspci -n
> >
> > I'm looking in the "Devices" Desktop shortcut (Mandriva2006). It appears
> > sda1, hda (DVD), hdb (DVD-Recorder) and floppy, but no reference to the
> > Pata HDD. This is the same as "device:/" in konqueror.
> > The output of the commands are attached.
>
> You don't seem to have VIA IDE driver compiled in et all.
>
> Could you retry with Daniel's patch applied and "VIA82CXXX chipset
> support" (CONFIG_BLK_DEV_VIA82CXXX config option) compiled-in?
> Yes, help entry should be updated. :-)
>
> Thanks,
> Bartlomiej

-------------------------------------------------------

-- 
João Esteves
joao.m.esteves@netcabo.pt
----------------------------------------------
"A imaginação é mais importante que o conhecimento"
Albert Einstein
