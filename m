Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSLJQJl>; Tue, 10 Dec 2002 11:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSLJQJl>; Tue, 10 Dec 2002 11:09:41 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:20946 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262414AbSLJQJk>; Tue, 10 Dec 2002 11:09:40 -0500
Date: Tue, 10 Dec 2002 16:17:25 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
Message-ID: <20021210161725.GA577@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Antonino Daplas <adaplas@pol.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1039522886.1041.17.camel@localhost.localdomain> <20021210131143.GA26361@suse.de> <1039538881.2025.2.camel@localhost.localdomain> <20021210144852.GD26361@suse.de> <1039547205.1086.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039547205.1086.25.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 12:07:45AM +0500, Antonino Daplas wrote:
 > > That chunk of X code is crap. So much so, that someone even put a
 > > comment there (not that what they suggested was much better).
 > > 
 > > See line 122 of http://www.atomised.org/docs/XFree86-4.2.1/agp_8c-source.html
 > > 
 > Ouch.  That's a sh??ty version check.  And it has to be present from
 > 4.0.0 to 4.2.1, and if they don't correct it, 4.3.0.

Andreas Schwab pointed out to me, that due to the broken boolean check,
I can bump the version to 0.100 and it'll work. At least until the
X folks change/remove that code.

        Dave

