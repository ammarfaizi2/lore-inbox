Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUBNRF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 12:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUBNRF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 12:05:58 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:5308 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262564AbUBNRF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 12:05:57 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Emmeran Seehuber <rototor@rototor.de>
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Date: Sat, 14 Feb 2004 12:05:52 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402112344.23378.rototor@rototor.de> <200402130223.00339.dtor_core@ameritech.net> <200402140928.18473.rototor@rototor.de>
In-Reply-To: <200402140928.18473.rototor@rototor.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402141205.52316.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 February 2004 04:28 am, Emmeran Seehuber wrote:
> On Friday 13 February 2004 07:23, Dmitry Torokhov wrote:
> [...]
> >
> > Do you have an active multiplexing controller and does passing i8042.nomux
> > option help?
> It seems so. At least passing this kernel option makes my PS/2 trackball work 
> again :)
> 
> Thank you!
> 
> cu,
>   Emmy
> 

Could you please #define DEBUG in drivers/input/serio/i8042.c and post your
dmesg? Also, what kind of PC is that (manufacturer/model)?

Thank you.

--
Dmitry
