Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316567AbSFDIfs>; Tue, 4 Jun 2002 04:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316568AbSFDIfr>; Tue, 4 Jun 2002 04:35:47 -0400
Received: from mail.medav.de ([213.95.12.190]:9491 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S316567AbSFDIfq> convert rfc822-to-8bit;
	Tue, 4 Jun 2002 04:35:46 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "Andre Hedrick" <andre@serialata.org>,
        "lkml" <linux-kernel@vger.kernel.org>, "Pawel Kot" <pkot@linuxnews.pl>
Date: Tue, 04 Jun 2002 10:35:49 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <1023149710.6773.82.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: Another -pre
Message-Id: <20020604073255.E96B8C7A@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Jun 2002 01:15:10 +0100, Alan Cox wrote:

>On Mon, 2002-06-03 at 15:55, Marcelo Tosatti wrote:
>> On Mon, 3 Jun 2002, Pawel Kot wrote:
>> 
>> > On Mon, 3 Jun 2002, Marcelo Tosatti wrote:
>> >
>> > > Due to some missing network fixes and -ac merge, I'll release another -pre
>> > > later today.
>> > >
>> > > -rc should be out by the end of the week.
>> >
>> > Would you please consider merging some IDE updates before releasing
>> > 2.4.19? Current version remains unusable for me.
>> > See http://marc.theaimsgroup.com/?l=linux-kernel&m=102277249800423&w=2
>> > and followers for more detailes.
>> 

>With the current code I've got these items on my list I class as
>problematic.

>1 Weird corruption report with AMD chipset in PIO mode
>1 NULL pointer crash report on SiS chipset
>2 Intel 845G issues (PIO only, incorrect BIOS setup)
>1 set of requested Promise changes 

>The 845G and Promise ones are present in both. The AMD one is utterly
>weird and I'm still looking at the SiS one.

Just for reference: my machine at home has a SiS645DX (ATA/133) plus a
Promise PDC20268 (ATA/100). The latest SUSE distribution (2.4.18 based)
falls flat on its face, the IDE drivers fail to handle both IDE
controllers.

Andre's patches supposedly fix the Promise issue, but the SiS problem
is still unresolved in Linux.

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


