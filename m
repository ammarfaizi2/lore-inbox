Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287615AbSABOAq>; Wed, 2 Jan 2002 09:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287693AbSABOAh>; Wed, 2 Jan 2002 09:00:37 -0500
Received: from bs1.dnx.de ([213.252.143.130]:9960 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S287655AbSABOAQ>;
	Wed, 2 Jan 2002 09:00:16 -0500
Date: Wed, 2 Jan 2002 14:55:05 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: <wingel@t1.ctrl-c.liu.se>
Cc: <hpa@zytor.com>, Linux Kernel List <linux-kernel@vger.kernel.org>,
        <jason@mugwump.taiga.com>, <anders@alarsen.net>, <rkaiser@sysgo.de>
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <20020102000609.6B6C136F9F@hog.ctrl-c.liu.se>
Message-ID: <Pine.LNX.4.33.0201021450460.3056-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Christer Weinigel wrote:
> > I'm also very uncomfortable with putting this where you do; I think it
> > should be put before a20_kbc instead.  If the BIOS is implemented
> > correctly, it should be used.
>
> I disagree, the Elan SC410 is an embedded CPU, it's used in systems
> that might not even have a BIOS (such as the Ericsson eBox that I've
> been working with).

Agreed. I think the CPU type is meant for "physical" CPU families, and the
Elan family is one, similar to "K6/K6-II/K6-III", "Athlon/Duron/K7" etc.
At the moment I don't change the category, let's hear what the maintainers
say once we've discussed the other bits and pieces.

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

