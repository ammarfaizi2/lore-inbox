Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbUBOPah (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbUBOPad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:30:33 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:16790 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265059AbUBOP2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:28:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Emmeran Seehuber <rototor@rototor.de>
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Date: Sun, 15 Feb 2004 10:28:24 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402112344.23378.rototor@rototor.de> <200402141205.52316.dtor_core@ameritech.net> <200402151425.15478.rototor@rototor.de>
In-Reply-To: <200402151425.15478.rototor@rototor.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402151028.25284.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 February 2004 09:25 am, Emmeran Seehuber wrote:
> On Saturday 14 February 2004 17:05, Dmitry Torokhov wrote:
> [...]
> > Could you please #define DEBUG in drivers/input/serio/i8042.c and post your
> > dmesg? Also, what kind of PC is that (manufacturer/model)?
> I've attached the output of dmesg with the i8042.nomux option and without. The 
> laptop is a Xeron Sonic Power Plus (Similar to this one: 
> http://www.xeron.com/index.php4?id=1255 -- sorry, there seems to be no 
> english translation of this page). Xeron puts together laptops in exact the 
> configuration you like. Only the motherboards are the same. But I don`t know 
> the motherboard vendor/type.  
> 

I see that the kernel correctly identifies both devices so I suspect there
could be a problem with your setup. Could you also post your XF86Config
and tell me the the options you are passing to GPM, please?

-- 
Dmitry
