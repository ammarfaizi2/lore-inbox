Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277152AbRKVKnV>; Thu, 22 Nov 2001 05:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277341AbRKVKnN>; Thu, 22 Nov 2001 05:43:13 -0500
Received: from [194.213.32.133] ([194.213.32.133]:36993 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S277152AbRKVKm4>;
	Thu, 22 Nov 2001 05:42:56 -0500
Date: Wed, 21 Nov 2001 00:31:19 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>
Cc: Patrick Mochel <mochel@osdl.org>,
        James Simmons <jsimmons@transvirtual.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New Power Managment code
Message-ID: <20011121003119.A37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0111160952090.21985-100000@segfault.osdlab.org> <Pine.LNX.4.30.0111161858520.22532-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0111161858520.22532-100000@Appserv.suse.de>; from davej@suse.de on Fri, Nov 16, 2001 at 07:02:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The power management transitions live in the most recent ACPI code, which
> > you can get from Intel:
> 
> Something I'm curious on wrt to this new work. Would it make sense for
> these callbacks to get called before/after APM suspend as well as ACPI ?
> (I'm thinking of older pre-ACPI compliant boxes).

With apm, bios/hw should do state saving itself. Doing it from os only
makes sense in order to work around bios bugs. It probably should not be
done as default.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

