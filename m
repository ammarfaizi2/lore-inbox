Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290021AbSAKTzT>; Fri, 11 Jan 2002 14:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290071AbSAKTzK>; Fri, 11 Jan 2002 14:55:10 -0500
Received: from lila.inti.gov.ar ([200.10.161.32]:57062 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S290021AbSAKTyz>;
	Fri, 11 Jan 2002 14:54:55 -0500
Message-ID: <3C3F4387.E8330684@inti.gov.ar>
Date: Fri, 11 Jan 2002 16:56:55 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: raul@dif.um.es, linux-kernel@vger.kernel.org
Subject: Re: compaq presario 706 EA via 686a sound card
In-Reply-To: <E16P7kZ-0000A0-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Its common for laptops to have some kind of amplifier control (to powersave
> better). Firstly does the problem show up with ACPI not compiled into the
> system ?
>
> If it still shows up then I guess you want to try flipping the EAPD bit
> on the AC97 codec and hoping that the amp was wired conventionally

I agree:
I just read the mail of other user with this problem. As I pointed in that
mail the codec seems to be AD1885 or newer (AD1885 is 0x60 and this machine
seems to have 0x61, maybe a revision, didn't have time to look for data
sheets).
The AD1885 needs EAPD control (default_ops) but as the coded wasn't detected
null_ops are used and the amplifier is blocked giving almost no volume.

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



