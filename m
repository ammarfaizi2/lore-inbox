Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVCDHZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVCDHZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVCDHZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:25:50 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:47756 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262605AbVCDHXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:23:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nKKKqNw9wbMVN/u8D2Tk+8HatShSYx4GjwLXbXxRgCv4lZu+cmROuaykB+aDF/4A4gJm5bVQlcW2dtsc/TBqx2Cy4ItO5pQaDhgzGv7NixXSRA3h+elArvPEmFViCA+MFZwO99QeubBTCg/hKuR1THyNIjQj77wsLdGw4YHq30o=
Message-ID: <29495f1d05030323232af64477@mail.gmail.com>
Date: Thu, 3 Mar 2005 23:23:13 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: gene.heskett@verizon.net
Subject: Re: 2.6.11 vs DVB cx88 stuffs
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org, hunold@linuxtv.org
In-Reply-To: <200503032119.04675.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200503032119.04675.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Mar 2005 21:19:04 -0500, Gene Heskett
<gene.heskett@verizon.net> wrote:
> Greetings;
> 
> I've a new pcHDTV-3000 card, and I thought maybe it would
> be a good idea to build the cx88 stuff in the DVB section
> of a make xconfig.
> 
> It doesn't build, spitting out this bailout:
> 
>   CC [M]  drivers/media/video/cx88/cx88-cards.o
> drivers/media/video/cx88/cx88-cards.c: In function `hauppauge_eeprom_dvb':
> drivers/media/video/cx88/cx88-cards.c:694: error: `PLLTYPE_DTT7595' undeclared (first use in this function)
> drivers/media/video/cx88/cx88-cards.c:694: error: (Each undeclared identifier is reported only once
> drivers/media/video/cx88/cx88-cards.c:694: error: for each function it appears in.)
> drivers/media/video/cx88/cx88-cards.c:698: error: `PLLTYPE_DTT7592' undeclared (first use in this function)
> drivers/media/video/cx88/cx88-cards.c: In function `cx88_card_setup':
> drivers/media/video/cx88/cx88-cards.c:856: error: `PLLTYPE_DTT7579' undeclared (first use in this function)
> make[4]: *** [drivers/media/video/cx88/cx88-cards.o] Error 1
> make[3]: *** [drivers/media/video/cx88] Error 2
> make[2]: *** [drivers/media/video] Error 2

FWIW, there is a similar, perhaps enough to be related, BugMe bug
(#4269): http://bugzilla.kernel.org/show_bug.cgi?id=4269

I had contacted Gerd Knorr (who I've CC'ed this mail to, to bring it
to his attention, as well as Michael Hunold) about the issue (as noted
in the BugMe entry) and he said he had patches setup for 2.6.12.

Gerd, would your patches fix these errors as well?

Thanks,
Nish
