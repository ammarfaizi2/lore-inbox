Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbSJASf1>; Tue, 1 Oct 2002 14:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262204AbSJASf1>; Tue, 1 Oct 2002 14:35:27 -0400
Received: from gate.in-addr.de ([212.8.193.158]:16900 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S262198AbSJASf0>;
	Tue, 1 Oct 2002 14:35:26 -0400
Date: Tue, 1 Oct 2002 20:42:26 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
Message-ID: <20021001184225.GC29788@marowsky-bree.de>
References: <Pine.GSO.4.21.0210011010380.4135-100000@weyl.math.psu.edu> <Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it> <20021001154808.GD126@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021001154808.GD126@suse.de>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-01T16:48:08,
   Dave Jones <davej@codemonkey.org.uk> said:

> No-one suggested 2.6.0 shipping without /something/, but having a dead
> LVM1 in _2.5_ doesn't help anyone.

Has the cabal (which does not exist) reached a verdict on the preferred
solution for 2.6 yet, so that we can sort of see where things are going?

Who has the hat "Volume Manager" on his gullible head? ;-)

I'll again pipe in for the radical solution: EVMS(powerful) on top of
device-mapper(elegant). 

EVMS also shows promise as they are working on _open_ cluster support, which I
think will be one of the big things to happen in 2.7. 

Rip out the compatibility cruft (LVM1, md and maybe others), as EVMS can do
everything they can as promised.

I'd understand if the compatibility "cruft" was still left in for 2.6 so
people could use the 2.6 timeframe to migrate and then finally kick it out
first thing in 2.7.

But then, I have a strong, explosive allergy to duplicated chunks of code.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel
Research and Development, SuSE Linux AG
 
``Immortality is an adequate definition of high availability for me.''
	--- Gregory F. Pfister

