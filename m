Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbQLRGub>; Mon, 18 Dec 2000 01:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130889AbQLRGuU>; Mon, 18 Dec 2000 01:50:20 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:7946 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129778AbQLRGuH>; Mon, 18 Dec 2000 01:50:07 -0500
Date: Mon, 18 Dec 2000 00:19:34 -0600
To: khromy <khromy@lnuxlab.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols pm_*register ad1848.o
Message-ID: <20001218001933.B3199@cadcamlab.org>
In-Reply-To: <20001217220851.A37686@lnuxlab.net> <20001218001634.A3199@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001218001634.A3199@cadcamlab.org>; from peter@cadcamlab.org on Mon, Dec 18, 2000 at 12:16:34AM -0600
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Peter Samuelson]
> Looks like your symbol versions got out of sync, somehow.

Uh, never mind, I didn't notice that pm.c is not listed as exporting
symbols.  Someone else just posted a patch -- add pm.o to the
'export-objs' line in kernel/Makefile.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
