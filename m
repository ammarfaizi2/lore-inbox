Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263530AbRFFQQs>; Wed, 6 Jun 2001 12:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263531AbRFFQQj>; Wed, 6 Jun 2001 12:16:39 -0400
Received: from h55t105.delphi.afb.lu.se ([130.235.188.122]:45582 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S263530AbRFFQQ1>;
	Wed, 6 Jun 2001 12:16:27 -0400
Date: Wed, 6 Jun 2001 18:16:08 +0200 (CEST)
From: Peter Svensson <petersv@psv.nu>
To: Chris Boot <bootc@worldnet.fr>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "David N. Welton" <davidw@apache.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: temperature standard - global config option?
In-Reply-To: <B74421C0.F6F7%bootc@worldnet.fr>
Message-ID: <Pine.LNX.4.33.0106061814470.1655-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Chris Boot wrote:

> I'm sorry, by I don't feel like adding 273 to every number I get just to
> find the temperature of something.  What I would do is give configuration
> options to choose the default (Celsius/centigrade, Kelvin, or [shudder]
> Fahrenheit) then, when you need to print or output a temperature, send it
> off to a common converter function so you don't repeat core all over the
> place.

Kelvin (decikelvin?) is probably a good unit to use in the kernel. If you
want something else you convert it in the programs you use to interact
with the kernel. This is a usespace issue, I think.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


