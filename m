Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbUL0Un1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUL0Un1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUL0Un0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:43:26 -0500
Received: from smtp-out3.iol.cz ([194.228.2.91]:13794 "EHLO smtp-out3.iol.cz")
	by vger.kernel.org with ESMTP id S261981AbUL0UnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:43:23 -0500
Message-ID: <41D073E6.3050207@stud.feec.vutbr.cz>
Date: Mon, 27 Dec 2004 21:43:18 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-ac1
References: <1104103881.16545.2.camel@localhost.localdomain> <58cb370e04122616577e1bd33@mail.gmail.com> <1104157999.20952.40.camel@localhost.localdomain> <20041227203146.GA27615@ime.usp.br>
In-Reply-To: <20041227203146.GA27615@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito wrote:
> I have an Asus A7V motherboard with chipset VIA KT133 and it has 2 VIA IDE
> (vt82c686a) controllers and 2 Promise PDC20265 controllers.

I used to have the same MB.

> I'm seeing an strange behaviour. Until yesterday I had a DVD reader (hdc)
> and an HP CD-Writer 9100 (hdd) both on the same VIA ide controller (ide1 in
> my system).
> 
> Unfortunately, with this setup, I could not burn a CD and read a CD-ROM of
> archived files at the same time.

I think that's normal.

> As it was a nuisance, I decided to put the
> CD-Writer on the Promise controller, which is an UDMA100 controller and,
> thus, I thought things would only get better.

I remember reading somewhere that one should not connect ATAPI devices 
to the Promise controller.

Michal
