Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVBFLBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVBFLBp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 06:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVBFLBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 06:01:45 -0500
Received: from pop.gmx.net ([213.165.64.20]:18061 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261162AbVBFLBg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 06:01:36 -0500
X-Authenticated: #14776911
From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
To: acpi-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [ACPI] Re: [RFC] Reliable video POSTing on resume
Date: Sun, 6 Feb 2005 12:05:13 +0100
User-Agent: KMail/1.7.2
Cc: Ondrej Zary <linux@rainbow-software.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050122134205.GA9354@wsc-gmbh.de> <200502051748.43547.stefandoesinger@gmx.at> <9e47339105020509382adbbf39@mail.gmail.com>
In-Reply-To: <9e47339105020509382adbbf39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502061205.14131.stefandoesinger@gmx.at>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 5. Februar 2005 18:38 schrieb Jon Smirl:
> On Sat, 5 Feb 2005 17:48:43 +0100, Stefan Dösinger
>
> <stefandoesinger@gmx.at> wrote:
> > The reset code of radeon card seems to be easy to reverse engineer. I
> > have started an attempt and I have 50-60% of my radeon M9 reset code
> > implemented in a 32 bit C program. I had to stop due to school reasons.
>
> The problem with the radeon reset code is that there are many, many
> variations of the radeon chips, including different steppings of the
> same part. The ROM is matched to the paticular bugs of the chip. From
> what I know ATI doesn't even have a universal radeon reset program.
I don't think they differ a lot. Does anybody know how the Win32 driver resets 
the card? If it calls 0xc000:3 it will also have the problem with overwritten 
reset code, and if it has it's own reset routine the cards can't differ a 
lot.
