Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284610AbSABVoy>; Wed, 2 Jan 2002 16:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284545AbSABVoo>; Wed, 2 Jan 2002 16:44:44 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:45699
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284542AbSABVo2>; Wed, 2 Jan 2002 16:44:28 -0500
Date: Wed, 2 Jan 2002 16:30:43 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102163043.A16513@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102161347.A16223@thyrsus.com> <Pine.LNX.4.33.0201022230240.427-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201022230240.427-100000@Appserv.suse.de>; from davej@suse.de on Wed, Jan 02, 2002 at 10:31:35PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
> Questionable. Dumping this in /proc just to make kernel autoconfig
> easier seems dreadful overkill.

Actually, that's far from the only reason I can think of for including it.

Consider the lives of people administering large server farms or clusters.
Their hardware is not necessarily homogenous, and the ability to query the DMI
tables on the fly could be useful both for administration and automatic
process migration.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The right to buy weapons is the right to be free.
        -- A.E. Van Vogt, "The Weapon Shops Of Isher", ASF December 1942
