Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRCHSyp>; Thu, 8 Mar 2001 13:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRCHSyf>; Thu, 8 Mar 2001 13:54:35 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:1548 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129495AbRCHSye>; Thu, 8 Mar 2001 13:54:34 -0500
Message-Id: <200103081853.f28IrrO43186@aslan.scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: jamagallon@able.es (J . A . Magallon),
        linux-kernel@vger.kernel.org (Linux Kernel)
Subject: Re: aic7xxx funcs without return values 
In-Reply-To: Your message of "Thu, 08 Mar 2001 11:56:32 GMT."
             <E14az23-0002ot-00@the-village.bc.nu> 
Date: Thu, 08 Mar 2001 11:53:53 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The bigger problem with that driver for pedants is that it contains globals
>with names like 'hard_error' which are asking for clashes . Bizarrely all
>the static functions are carefully named ahc_* and the globals are called
>things like 'restart_squencer'

Such is the evolutionary nature of most drivers.  I just spent a bit
of time cleaning this up.  Some of the exported symbols didn't even
need to be in the current layout of the driver.

Thanks for the reminder.
Justin
