Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273270AbRINDFv>; Thu, 13 Sep 2001 23:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273269AbRINDFl>; Thu, 13 Sep 2001 23:05:41 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:49797
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S273270AbRINDFg>; Thu, 13 Sep 2001 23:05:36 -0400
Date: Thu, 13 Sep 2001 20:02:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: jgarzik@mandrakesoft.com, becker@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endian-ness bugs in yellowfin.c
Message-ID: <20010913200237.P21906@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010913195141.B799@boardwalk> <20010913193937.O21906@cpe-24-221-152-185.az.sprintbbd.net> <20010913205459.A1169@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010913205459.A1169@boardwalk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 08:55:01PM -0600, Val Henson wrote:
> On Thu, Sep 13, 2001 at 07:39:37PM -0700, Tom Rini wrote:
> > On Thu, Sep 13, 2001 at 07:51:41PM -0600, Val Henson wrote:
> > > -      tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_NCR885E
> > > +      tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_YELLOWFIN
> > 
> > Since you're killing this, why not just remove this question entirely?
> 
> This is one of the "design decisions" I referred to.  It makes no
> sense to list a 100 Mbit driver under "Ethernet (1000 Mbit)".  This is
> my solution.  This is the first case of a dual 1000/100 Mbit driver
> and if there's a better way to handle it I'd like to hear it.

Er, sungem does 10/100/1000 too I think.. (It's what's in the new G4
towers..).  IMHO, listing it once under the greatest makes sense.  But
sungem/gmac are under 10/100 I think.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
