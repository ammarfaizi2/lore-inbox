Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbSBOCLf>; Thu, 14 Feb 2002 21:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286303AbSBOCL3>; Thu, 14 Feb 2002 21:11:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33810 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286188AbSBOCLS>;
	Thu, 14 Feb 2002 21:11:18 -0500
Message-ID: <3C6C6E3C.8452F48B@mandrakesoft.com>
Date: Thu, 14 Feb 2002 21:11:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <Pine.LNX.4.33.0202131043230.13632-100000@home.transmeta.com> <3C6AA01A.51517C48@mandrakesoft.com> <20020214092753.A37@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > As an experiment a couple months ago, I got most of the PCI net drivers
> > down to ~200-300 lines of C code apiece, by factoring out common code
> > patterns into M4 macros.  "m4 netdrivers.m4 epic100.tmpl > epic100.c"
> 
> This is slightly extreme, right?
> 
> But I'd like to see resulting epic100.tmpl ;-).

When you have to maintain more than 10 "cookie cutter" net drivers that
are 80-90% the same, you start to want such extremes :)

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
