Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281096AbRKUBVK>; Tue, 20 Nov 2001 20:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281554AbRKUBVB>; Tue, 20 Nov 2001 20:21:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28427 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281096AbRKUBUt>; Tue, 20 Nov 2001 20:20:49 -0500
Subject: Re: swsusp for 2.4.14
To: pavel@suse.cz (Pavel Machek)
Date: Wed, 21 Nov 2001 01:24:57 +0000 (GMT)
Cc: swsusp@lister.fornax.hu (Swsusp mailing list),
        acpi@phobos.fachschaften.tu-muenchen.de (ACPI mailing list),
        linux-kernel@vger.kernel.org (kernel list),
        seasons@falcon.sch.bme.hu (Gabor Kuti)
In-Reply-To: <20011121001858.B183@elf.ucw.cz> from "Pavel Machek" at Nov 21, 2001 12:18:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E166M8H-0003QH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Warning. This probably corrupts memory. (All previous versinos did,
> just noone noticed becuase it needed 20+ suspend/resume cycles). This
> is probably best version ever, but it still corrupts data.

Has anyone tried porting swsusp to user mode linux. That way you could
actually "suspend" a copy, resume it in parallel with the original and
compare the two memory images ?
