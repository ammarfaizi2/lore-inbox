Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272451AbRIUIxH>; Fri, 21 Sep 2001 04:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272465AbRIUIw5>; Fri, 21 Sep 2001 04:52:57 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:1805 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S272451AbRIUIwr>;
	Fri, 21 Sep 2001 04:52:47 -0400
Date: Fri, 21 Sep 2001 10:52:40 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Knut.Neumann@rz.uni-duesseldorf.de,
        ACPI list <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: SonyPI Driver
Message-ID: <20010921105240.C739@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20010918182011.G14639@come.alcove-fr> <20010920092313.A38@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010920092313.A38@toy.ucw.cz>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 09:23:14AM +0000, Pavel Machek wrote:

> > You'll have to wait for ACPI suspend support in the kernel
> > (some support will get into the 2.5 kernel series) or choose between
> > the sonypi driver and APM suspend.
> 
> Patrick Mochel has some patches for ACPI to enable suspend-to-ram
> [problems with vesafb nd evices, otherwise ok], and
> I'm currently working on suspend-to-disk [will work in easy cases].
> See acpi list.

Yes, I saw this and I keep looking at those, some day I might even
try them. :-)

The main problem for me now is that the current ACPI code does pretty
nothing on my laptop (Sony Vaio C1VE): no battery status, no event
recorded etc... This was already reported on the acpi list some
time ago.

I'm adding a CC: to the ACPI list just in case someone has an idea
on how to make ACPI working for me. If this is not an already known
problem just tell me and I will compile an ACPI enabled kernel again
and give additionnal details / debug info.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
