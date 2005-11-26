Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbVKZEMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbVKZEMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 23:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbVKZEMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 23:12:55 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:59636 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932719AbVKZEMy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 23:12:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CQVYLHJK2fIrmywBberMUUfOHO6JyQ0SF6tOuF0LMaH7WLt0S7f4YbbEIzELgjeRsj43eSGic88U5N3yU9KId6b9X4h6LvDD0ePXY+SonqYBaO10hQDyYnG4fN8yq+f6TeqgaXNfaQXIy4hpkjlFPFo87de7nLbZMQSjZOcMZTs=
Message-ID: <e3e24c6a0511252012v52a26698ua1d8b73eda2133fb@mail.gmail.com>
Date: Sat, 26 Nov 2005 09:42:54 +0530
From: Vishal Linux <vishal.linux@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: How to get SDA/SCL bit position in the control word register of the video card?
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051125203300.0899e9b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e3e24c6a0511240245i1d395ae6g4d768a75a602d6ce@mail.gmail.com>
	 <20051125203300.0899e9b7.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/05, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Vishal,
Hello Mr. Delvare,

>
> First of all, I would suggest that you post using your real name.
> Pretending that you are Linux on your own will not make you popular

This was funny and what is also sometimes considered as ASSUMING something
and JUMPING to conclusion and JUDGING people without knowing them.

My actual name is Vishal Soni and my email address for personal
communication is
vishal.soni.1@gmail.com

I created email address vishal.linux so that i can dedicate one email
address to the mailing lists for my linux interest and the hundred of
mails, which keeps coming to the mailing list does not block my
personal mails.

You wrote.........
" Pretending that you are Linux on your own will not make you popular"
I don't really give damn to the popularity. I am just another open
source community fan, who is trying to learn about linux and enjoy it.
And open source community dudes are no fools that they wud be getting
this kind of weird feeling and wud make any X,Y,Z........ The LINUX
owner :).

This also reminds me about the real meaning of assume,
 (ASSuME) "Making Ass out of You and Me."

So please don't judge the people without knowing them. Every one's way
of thinking and doing things is different.

>
> > I am trying to communicate to the monitor eeprom to get the monitor
> > capabilities and for that i need to have SDA/SCL bit positions in the

>
> > I tried to use linux kernel API char* get_EDID_from_BIOS(void*) and
> > then using kgdb to debug the kernel module (that i wrote) to get the
> > same  but failed to find the way to get the above.
>
> I couldn't find any function by that name in the Linux kernel source
> tree. What are you talking about?
/usr/src/linux-2.6.x/include/video/edid.h




>
> > I do have the offset of the control word register and Masking Value of
> > Intel and Matrox card but i would like NOT to hardcode the masking
> > value and the offset in my code. This will lead me to modify  my code
> > for the different cards.
> >
> > Is there any way to get the control word register's address (and then
> > SDA/SCL bit position) on the linux operating system. Is this
> > information available to linux kernel ?
>
> Support for different hardware belong to different drivers. If you are
> trying to put support for many incompatible chips in a single driver,
Yeah this is not to be done..........

> you're doing something wrong.
As i said........ in the subject i was trying to .........
to get SDA/SCL bit position in the control word register of the video card?

so that i can communicate to the monitor......... without hardcoding
the offset of control word register in my code for every different
card.


> You may also want to take a look at an older program called read-edid
> [2], which does actually attempt to use the BIOS to retrieve the EDID,
> with varying success, then decodes it in a form suitable for X
> configuration files. This can be used in combination with another
> script from the lm_sensors package, decode-edid.pl [3], to get the same
> output from the i2c adapter and eeprom modules instead of BIOS.
>
> [1] http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/eeprom/ddcmon
> [2] http://john.fremlin.de/programs/linux/read-edid/
> [3] http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/eeprom/decode-edid.pl
Yes i am studying the code.......of read-edid .
Thankyou for your time.

Vishal.

>
> --
> Jean Delvare
>
