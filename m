Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281128AbRKUCzw>; Tue, 20 Nov 2001 21:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281159AbRKUCzn>; Tue, 20 Nov 2001 21:55:43 -0500
Received: from mnh-1-22.mv.com ([207.22.10.54]:40462 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S281128AbRKUCzc>;
	Tue, 20 Nov 2001 21:55:32 -0500
Message-Id: <200111210412.XAA05883@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Adam Feuer <adamf@pobox.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@suse.cz>,
        Swsusp mailing list <swsusp@lister.fornax.hu>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Gabor Kuti <seasons@falcon.sch.bme.hu>
Subject: Re: [swsusp] Re: swsusp for 2.4.14 
In-Reply-To: Your message of "Tue, 20 Nov 2001 18:07:15 PST."
             <20011120180715.N11355@sunflower.zipcon.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Nov 2001 23:12:44 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adamf@pobox.com said:
> but will not resume afterwards... just boots normally. Suspending
> doesn't seem to write the swsusp signature to the swap partition... 

It sounds like you need a hook into the early UML boot process.  Tell me
what functionality you need and I'll tell you where to put the code...

				Jeff

