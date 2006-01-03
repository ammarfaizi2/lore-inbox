Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWACLk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWACLk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 06:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWACLk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 06:40:57 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:17890 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751379AbWACLk4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 06:40:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wgp9OQSev+jB1AIS8mlR1g2vwP0KGvjrmRLU6JUeBKHFs4jJ3t/ApGN7FfaQpTISmwFeyVIOaKB1DYyxExYB9rvOTfJf34LvC3XVwKrU6TZq+Y3Yb895uzIaXVdpD8BiJSZoKvXSHUm9abAbtbs66MXkwntWQ5tTSakd/1Y+s+w=
Message-ID: <58cb370e0601030340jbad02f0m6073dae957384c9b@mail.gmail.com>
Date: Tue, 3 Jan 2006 12:40:55 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: =?ISO-8859-1?Q?Jo=E3o_Esteves?= <joao.m.esteves@netcabo.pt>
Subject: Re: Via VT 6410 Raid Controller
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601031055.02257.joao.m.esteves@netcabo.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200601021253.10738.joao.m.esteves@netcabo.pt>
	 <200601021647.27453.joao.m.esteves@netcabo.pt>
	 <43B95D20.3060401@gentoo.org>
	 <200601031055.02257.joao.m.esteves@netcabo.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/3/06, João Esteves <joao.m.esteves@netcabo.pt> wrote:
> Thank you, Daniel.
> > >
> >
> > Can you explain what you mean by you don't "see" it? Where are you looking?
> >
> > You could also post the output of:
> >       dmesg
> >       lspci
> >       lspci -n
>
> I'm looking in the "Devices" Desktop shortcut (Mandriva2006). It appears sda1,
> hda (DVD), hdb (DVD-Recorder) and floppy, but no reference to the Pata HDD.
> This is the same as "device:/" in konqueror.
> The output of the commands are attached.

You don't seem to have VIA IDE driver compiled in et all.

Could you retry with Daniel's patch applied and "VIA82CXXX chipset
support" (CONFIG_BLK_DEV_VIA82CXXX config option) compiled-in?
Yes, help entry should be updated. :-)

Thanks,
Bartlomiej
