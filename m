Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273319AbRING2v>; Fri, 14 Sep 2001 02:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273316AbRING2l>; Fri, 14 Sep 2001 02:28:41 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:33546 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S273319AbRING23>;
	Fri, 14 Sep 2001 02:28:29 -0400
Date: Fri, 14 Sep 2001 00:15:40 -0600
From: Val Henson <val@nmt.edu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: jgarzik@mandrakesoft.com, becker@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endian-ness bugs in yellowfin.c
Message-ID: <20010914001540.B2951@boardwalk>
In-Reply-To: <20010913195141.B799@boardwalk> <20010913193937.O21906@cpe-24-221-152-185.az.sprintbbd.net> <20010913205459.A1169@boardwalk> <20010913200237.P21906@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010913200237.P21906@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Thu, Sep 13, 2001 at 08:02:37PM -0700
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 08:02:37PM -0700, Tom Rini wrote:
> On Thu, Sep 13, 2001 at 08:55:01PM -0600, Val Henson wrote:
> > 
> > This is one of the "design decisions" I referred to.  It makes no
> > sense to list a 100 Mbit driver under "Ethernet (1000 Mbit)".  This is
> > my solution.  This is the first case of a dual 1000/100 Mbit driver
> > and if there's a better way to handle it I'd like to hear it.
> 
> Er, sungem does 10/100/1000 too I think.. (It's what's in the new G4
> towers..).  IMHO, listing it once under the greatest makes sense.  But
> sungem/gmac are under 10/100 I think.

You misunderstood what I meant.  This is the first case of one driver
supporting two different cards, one 10/100 and one 10/100/1000.  All
the gigabit cards are 10/100/1000 as far as I know.  I still think the
driver should be listed in both the 100 Mbit and 1000 Mbit Ethernet
menu sections, unless someone comes up with a better idea.

-VAL
