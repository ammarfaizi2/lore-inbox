Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbTAGGII>; Tue, 7 Jan 2003 01:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbTAGGII>; Tue, 7 Jan 2003 01:08:08 -0500
Received: from almesberger.net ([63.105.73.239]:51717 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267310AbTAGGII>; Tue, 7 Jan 2003 01:08:08 -0500
Date: Tue, 7 Jan 2003 03:16:38 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Valdis.Kletnieks@vt.edu
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <20030107031638.D1406@almesberger.net>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org> <17360000.1041899978@localhost.localdomain> <20030107042045.GA10045@waste.org> <200301070538.h075cICR004033@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301070538.h075cICR004033@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Tue, Jan 07, 2003 at 12:38:18AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> is currently busticated for gigabit and higher (it takes *hours* without a
> packet drop to get the window open *all* the way

Don't use 2.0.21 for gigabit traffic :-)

(2.0.21 and earlier initialized sstresh to zero, which would indeed
cause the behaviour you're describing.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
