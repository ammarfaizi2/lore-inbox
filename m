Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265548AbUF2Oce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbUF2Oce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 10:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUF2Oce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 10:32:34 -0400
Received: from web81303.mail.yahoo.com ([206.190.37.78]:30398 "HELO
	web81303.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265548AbUF2Occ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 10:32:32 -0400
Message-ID: <20040629143232.52963.qmail@web81303.mail.yahoo.com>
Date: Tue, 29 Jun 2004 07:32:32 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
To: Marc Waeckerlin <marc.waeckerlin@siemens.com>
Cc: t.hirsch@web.de, laflipas@telefonica.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Waeckerlin wrote:
> Am Freitag, 25. Juni 2004 16.02 schrieb Dmitry Torokhov unter "Re:
> Continue:
> psmouse.c - synaptics touchpad driver sync problem":
> > Anyway, I also have a tiy patch to try out (attached, not tested/
> > not compiled). Please let me know how ifit makes any improvement.
> 
> Sorry for the delay.
> 
> No, unfortunately no improvement at all.
>
 
Yeah, I figure there would not be any. Still I have a nagging suspicion
that the mux gets confused and I would like to see the full dmesg with
this patch applied and DEBUG enabled. Is there any change of getting it?

Actually, if you could change the patch so it would print not only data
but also str, like this:

printk(KERN_INFO "i8042.c: MUX reports error condition %02x (%02x)\n",
       data, str);

it would be even better.

Thanks!

--
Dmitry 
