Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290085AbSAKUJj>; Fri, 11 Jan 2002 15:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290086AbSAKUJW>; Fri, 11 Jan 2002 15:09:22 -0500
Received: from lila.inti.gov.ar ([200.10.161.32]:10471 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S290085AbSAKUJB>;
	Fri, 11 Jan 2002 15:09:01 -0500
Message-ID: <3C3F46D5.3DFF5B57@inti.gov.ar>
Date: Fri, 11 Jan 2002 17:11:01 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, raul@dif.um.es,
        linux-kernel@vger.kernel.org
Subject: Re: compaq presario 706 EA via 686a sound card
In-Reply-To: <E16P7kZ-0000A0-00@the-village.bc.nu> <3C3F4387.E8330684@inti.gov.ar>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

salvador wrote:

> Alan Cox wrote:
>
> > Its common for laptops to have some kind of amplifier control (to powersave
> > better). Firstly does the problem show up with ACPI not compiled into the
> > system ?
> >
> > If it still shows up then I guess you want to try flipping the EAPD bit
> > on the AC97 codec and hoping that the amp was wired conventionally
>
> I agree:
> I just read the mail of other user with this problem. As I pointed in that
> mail the codec seems to be AD1885 or newer (AD1885 is 0x60 and this machine
> seems to have 0x61, maybe a revision, didn't have time to look for data
> sheets).

Replying to myself ;-), it seems to be AD1886 chip, can't get the datasheet but
1885 is 0x60 and 1887 datasheet says 0x62, I can bet 0x61 is 1886 and the user
should try adding it to the ac97_module.c list using the same options that 1885
use.

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



