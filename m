Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267568AbTALWVE>; Sun, 12 Jan 2003 17:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267564AbTALWVE>; Sun, 12 Jan 2003 17:21:04 -0500
Received: from kerberos.ncsl.nist.gov ([129.6.57.216]:10374 "EHLO
	kerberos.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S267568AbTALWVC>; Sun, 12 Jan 2003 17:21:02 -0500
Date: Sun, 12 Jan 2003 17:29:51 -0500
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112172951.A12413@kerberos.ncsl.nist.gov>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112211530.GP27709@mea-ext.zmailer.org> <1042406849.3162.121.camel@RobsPC.RobertWilkens.com> <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com> <1042407845.3162.131.camel@RobsPC.RobertWilkens.com> <32929.62.98.226.220.1042408728.squirrel@webmail.roma2.infn.it> <1042409562.1209.142.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1042409562.1209.142.camel@RobsPC.RobertWilkens.com>; from robw@optonline.net on Sun, Jan 12, 2003 at 05:12:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 05:12:42PM -0500, Rob Wilkens wrote:
> Kernel size (footprint in memory) would grow a tad bit (not much), but
> it's overall speed would also go up.  

No, it would go down.  The damage may not be too great thanks to GCSE,
but even that isn't sure especially if asms (via locking code) are
involved.  You really need to brush up on current computer
architectures.  Look in particular the L1 caches structures, cacheline
sizes, cache sizes and branch prediction.  And of course current
compiler technology, so that you actually know what code is generated.

  OG.

PS: I know, don't feed the troll, sorry.
