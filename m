Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVBSQXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVBSQXr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 11:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVBSQXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 11:23:47 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:48581 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261698AbVBSQXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 11:23:46 -0500
Date: Sat, 19 Feb 2005 17:23:42 +0100
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: FAUmachine: Looking for a good documented DMA bus master capable PCI IDE Controller card
Message-ID: <20050219162342.GA29455@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <20050219102410.GD16858@cip.informatik.uni-erlangen.de> <58cb370e05021903481de251df@mail.gmail.com> <20050219132606.GH16858@cip.informatik.uni-erlangen.de> <58cb370e050219055337ca9d62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e050219055337ca9d62@mail.gmail.com>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Hm, maybe you will have to implement some PCI add-on IDE controller,
> AFAIR Silicon Image 680 datasheet is publicly available now.

I just talked with a coworker who has experience with the above card. He
told me that this IDE controller (hardware) has havy problems if you
have havy load on both channels. (Blue screens in windows and DMA errors
in Linux).

He also told me that everything works fine if you use one channel in PIO
mode and that there are workarounds in the linux kernel to circumvent
the upcomming problems under havy load.

Is that true or just nonsense?

However it is worth to look at them. Thanks for the pointer! :-)

	Thomas
