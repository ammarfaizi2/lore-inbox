Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130842AbRAPMOT>; Tue, 16 Jan 2001 07:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131418AbRAPMOJ>; Tue, 16 Jan 2001 07:14:09 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:34570 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130842AbRAPMNy>; Tue, 16 Jan 2001 07:13:54 -0500
Date: Tue, 16 Jan 2001 06:13:42 -0600
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: O_ANY  [was: Re: 'native files', 'object fingerprints' [was: sendpath()]]
Message-ID: <20010116061342.C12650@cadcamlab.org>
In-Reply-To: <20010116123743.A32075@gruyere.muc.suse.de> <Pine.LNX.4.30.0101161242180.529-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.30.0101161242180.529-100000@elte.hu>; from mingo@elte.hu on Tue, Jan 16, 2001 at 01:04:22PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Ingo Molnar]
> - probably the most radical solution is what i suggested, to
> completely avoid the unique-mapping of file structures to an integer
> range, and use the address of the file structure (and some cookies)
> as an identification.

Careful, these must cast to non-negative integers, without clashing.

> 	fd = open(...,O_ANY);

I like this idea, but call it O_ALLOCANYFD.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
