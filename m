Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbTATJ1K>; Mon, 20 Jan 2003 04:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbTATJ1K>; Mon, 20 Jan 2003 04:27:10 -0500
Received: from pollux.et6.tu-harburg.de ([134.28.85.242]:14721 "EHLO
	mail.et6.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S263313AbTATJ1J>; Mon, 20 Jan 2003 04:27:09 -0500
Subject: Re: Promise SuperTrak SX6000 w/ kernel 2.4.20
From: Sebastian Zimmermann <S.Zimmermann@tu-harburg.de>
To: "Juergen \"George\"   " Sawinski <george@mpimf-heidelberg.mpg.de>
Cc: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <1042716221.10222.4.camel@volans>
References: <1042712859.14520.39.camel@antares.et6.tu-harburg.de>
	 <1042716221.10222.4.camel@volans>
Content-Type: text/plain
Organization: Technical University Hamburg-Harburg
Message-Id: <1043055372.1132.7.camel@antares.et6.tu-harburg.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 20 Jan 2003 10:36:12 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2003-01-16 um 12.23 schrieb Juergen "George" Sawinski:
> It shouldn't find /dev/hde ... /dev/hdj (there's some problem with the
> detection mechanism), as these are I2O devices, and thus it's
> /dev/i2o/hd?. You have to stop the discovery process by adding 
> 
> hde=noprobe hdf=noprobe hdg=noprobe hdh=noprobe hdi=noprobe hdj=noprobe
> 
> to the lilo append variable.

Yes, thank you. Now I can boot. (I also had to add /dev/hdm and /dev/hdo
though.)

Nonetheless, I still consider this a kernel bug. The kernel should boot
without the workaround as it did with version 2.4.18.

Sebastian


