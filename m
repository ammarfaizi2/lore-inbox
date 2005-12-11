Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVLKS2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVLKS2k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVLKS2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:28:40 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:40565 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750778AbVLKS2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:28:38 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Subject: Re: [PATCH] drivers/input/misc: Added Acer TravelMate 240 support to the wistron button interface
Date: Sun, 11 Dec 2005 13:28:33 -0500
User-Agent: KMail/1.8.3
Cc: Miloslav Trmac <mitr@volny.cz>, bero@arklinux.org, dtor@mail.ru,
       akpm@osdl.org, vojtech@suse.cz, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-laptop@vger.kernel.org
References: <81083a450512102116o50d71fa0gbb53557f0e3d8748@mail.gmail.com> <439BB8CC.4000301@volny.cz> <81083a450512102148u2db386aat7ad51056bcc02f82@mail.gmail.com>
In-Reply-To: <81083a450512102148u2db386aat7ad51056bcc02f82@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111328.35858.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 December 2005 00:48, Ashutosh Naik wrote:
> On 12/11/05, Miloslav Trmac <mitr@volny.cz> wrote:
> 
> > > This patch adds Acer TravelMate 240 support to the wistron button
> > > interface. This means that the buttons on top of the
> > > keyboard(including ones for Wifi and Bluetooth),  which hitherto did
> > > not work, work now. I have tested it on my laptop and it seems to work
> > > great.
> > Please check that the ACPI "button.ko" driver can't provide the
> > functionality; newer laptops apparently work better with that driver
> > (http://lkml.org/lkml/2005/12/2/61).
> 
> The Acer TravelMate 240 laptop supports ACPI, but the ACPI does not
> support hotkeys. Hence hotkeys just would not work without this
> module.
>

I added this to my input tree.

-- 
Dmitry
