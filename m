Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129399AbRA2SQJ>; Mon, 29 Jan 2001 13:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRA2SQA>; Mon, 29 Jan 2001 13:16:00 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:64785 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129399AbRA2SPr>; Mon, 29 Jan 2001 13:15:47 -0500
Message-ID: <3A75B34C.E3B43B86@Hell.WH8.TU-Dresden.De>
Date: Mon, 29 Jan 2001 19:15:40 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: eepro100 - Linux vs. FreeBSD
In-Reply-To: <Pine.LNX.4.31ksi3.0101290957530.25829-100000@nomad.cyberbills.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Kubushin wrote:
> 
> The older chips (e.g. 82557) work fine. The problem arises when you have the
> newer 82559's. They do work, however, if the power management for eepro100
> is enabled in kernel config. It definitely means that those chips are
> underinitialized (or overinitialized :)) when it's not.

Andrey posted a patch last week, which obviously fixes the 82559 problems.
It's in Linus' latest 2.4.1-pre release too. I have an 82559 and with the
patch there've been no issues here yet - so things are looking good so far.

I suggest that instead of having 3 drivers (eepro100, e100, freebsd), people
should just work together, look at the goodies of each driver and merge them
into one perfect driver.

Regards,
-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
