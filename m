Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262964AbSJBET6>; Wed, 2 Oct 2002 00:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262965AbSJBET6>; Wed, 2 Oct 2002 00:19:58 -0400
Received: from thunk.org ([140.239.227.29]:49080 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262964AbSJBET6>;
	Wed, 2 Oct 2002 00:19:58 -0400
Date: Wed, 2 Oct 2002 00:24:35 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
Message-ID: <20021002042434.GA13971@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lars Marowsky-Bree <lmb@suse.de>,
	Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0210011010380.4135-100000@weyl.math.psu.edu> <Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it> <20021001154808.GD126@suse.de> <20021001184225.GC29788@marowsky-bree.de> <1033520458.20284.46.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033520458.20284.46.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 02:00:58AM +0100, Alan Cox wrote:
> DM is small and clean. It may well be that if we go the DM way (and I
> think we should) that those bits of EVMS that we want (like cluster)
> actually come out a lot cleaner than in EVMS itself

DM is small and clean because it's severely lacking in functionality.
Last I checked it couldn't do RAID 5 or r/w snapshots without
completely bypassing its core infrastructure (since you're no longer
just doing simple block remapping at that point), and once you add all
that stuff, it's likely to become much more complex.

							- Ted
