Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261832AbTCaU3a>; Mon, 31 Mar 2003 15:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261833AbTCaU3a>; Mon, 31 Mar 2003 15:29:30 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:17419 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261832AbTCaU3a>;
	Mon, 31 Mar 2003 15:29:30 -0500
Date: Mon, 31 Mar 2003 22:40:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Michael Buesch <freesoftwaredeveloper@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make menuconfig error
Message-ID: <20030331204051.GA1673@mars.ravnborg.org>
Mail-Followup-To: Michael Buesch <freesoftwaredeveloper@web.de>,
	linux-kernel@vger.kernel.org
References: <200303312134.38818.freesoftwaredeveloper@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303312134.38818.freesoftwaredeveloper@web.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 09:34:38PM +0200, Michael Buesch wrote:
>$ make menuconfig
> #
> # using defaults found in .config
> #
Ok, it reads configuration from your old .config

> .config:763: trying to assign nonexistent symbol INTEL_RNG

Your old configuration assigned a value to INTEL_RNG, that symbol
seems to have disappered in the later kernels.
So actually no bug, just a report about an inconsistency in your
old configuration.

	Sam
