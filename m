Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131045AbQLVQDN>; Fri, 22 Dec 2000 11:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131209AbQLVQDD>; Fri, 22 Dec 2000 11:03:03 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:30981 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S131045AbQLVQCz>; Fri, 22 Dec 2000 11:02:55 -0500
Date: Fri, 22 Dec 2000 17:32:28 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre3
Message-ID: <20001222173228.A1424@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E149GRm-0003sX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E149GRm-0003sX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 22, 2000 at 12:52:32AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 12:52:32AM +0000, Alan Cox wrote:
> 
> o	Optimise kernel compiler detect, kgcc before	(Peter Samuelson)
> 	gcc272 also

kwhich doesn't seem to work ok with several arguments if sh is bash-1.14.7:

$ sh scripts/kwhich kgcc gcc272 cc gcc
kgcc:gcc272:cc:gcc: not found

If sh is bash-2.04 or ash-0.3.7 it works ok:

$ sh scripts/kwhich kgcc gcc272 cc gcc
/usr/bin/kgcc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
