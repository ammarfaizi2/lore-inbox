Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281521AbRKUCJh>; Tue, 20 Nov 2001 21:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281531AbRKUCJZ>; Tue, 20 Nov 2001 21:09:25 -0500
Received: from zipcon.net ([209.221.136.5]:31507 "HELO zipcon.net")
	by vger.kernel.org with SMTP id <S281521AbRKUCJU>;
	Tue, 20 Nov 2001 21:09:20 -0500
Date: Tue, 20 Nov 2001 18:07:15 -0800
From: Adam Feuer <adamf@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@suse.cz>,
        Swsusp mailing list <swsusp@lister.fornax.hu>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Gabor Kuti <seasons@falcon.sch.bme.hu>
Subject: Re: [swsusp] Re: swsusp for 2.4.14
Message-ID: <20011120180715.N11355@sunflower.zipcon.net>
In-Reply-To: <20011121001858.B183@elf.ucw.cz> <E166M8H-0003QH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E166M8H-0003QH-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 21, 2001 at 01:24:57AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox <alan@lxorguk.ukuu.org.uk>:
> Has anyone tried porting swsusp to user mode linux. That way you could
> actually "suspend" a copy, resume it in parallel with the original and
> compare the two memory images ?

Alan,
  I got swsusp-2.4.13 (from Florent) to compile on User Mode Linux
2.4.13, with a couple of changes... it seems to suspend, but will not
resume afterwards... just boots normally. Suspending doesn't seem to
write the swsusp signature to the swap partition... 
  I haven't gone any farther than that yet. I can provide a diff
against uml-2.4.13 if anyone is interested in helping. :-)

cheers
adam
--
Adam Feuer <adamf@pobox.com>      http://www.pobox.com/~adamf/
