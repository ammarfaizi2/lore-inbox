Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130670AbQKNFnp>; Tue, 14 Nov 2000 00:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130747AbQKNFnf>; Tue, 14 Nov 2000 00:43:35 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:52239 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130670AbQKNFnU>; Tue, 14 Nov 2000 00:43:20 -0500
Date: Mon, 13 Nov 2000 23:10:08 -0600
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops on 2.2.17 [klogd bonus question]
Message-ID: <20001113231008.G18203@wire.cadcamlab.org>
In-Reply-To: <20001113162155.A18009@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001113162155.A18009@jaquet.dk>; from rasmus@jaquet.dk on Mon, Nov 13, 2000 at 04:21:55PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Rasmus Andersen]
> I'm getting oopses on a linux 2.2.17 box when I try to do
> tar cvIf <file> -X<file> /. Reproducably.

Are you excluding /proc?  Trying to back up all of /proc is definitely
asking for trouble, although the oops still indicates a kernel bug.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
