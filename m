Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273272AbRINDIV>; Thu, 13 Sep 2001 23:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273271AbRINDIB>; Thu, 13 Sep 2001 23:08:01 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:18192 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S273269AbRINDHz>;
	Thu, 13 Sep 2001 23:07:55 -0400
Date: Thu, 13 Sep 2001 20:55:01 -0600
From: Val Henson <val@nmt.edu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: jgarzik@mandrakesoft.com, becker@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endian-ness bugs in yellowfin.c
Message-ID: <20010913205459.A1169@boardwalk>
In-Reply-To: <20010913195141.B799@boardwalk> <20010913193937.O21906@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010913193937.O21906@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Thu, Sep 13, 2001 at 07:39:37PM -0700
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 07:39:37PM -0700, Tom Rini wrote:
> On Thu, Sep 13, 2001 at 07:51:41PM -0600, Val Henson wrote:
> > -      tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_NCR885E
> > +      tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_YELLOWFIN
> 
> Since you're killing this, why not just remove this question entirely?

This is one of the "design decisions" I referred to.  It makes no
sense to list a 100 Mbit driver under "Ethernet (1000 Mbit)".  This is
my solution.  This is the first case of a dual 1000/100 Mbit driver
and if there's a better way to handle it I'd like to hear it.

-VAL
