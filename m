Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131061AbQLQJH3>; Sun, 17 Dec 2000 04:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132005AbQLQJHT>; Sun, 17 Dec 2000 04:07:19 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:11526 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131061AbQLQJHI>; Sun, 17 Dec 2000 04:07:08 -0500
Date: Sun, 17 Dec 2000 02:36:24 -0600
To: John Fort <johnf@whitsunday.net.au>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 17 month late patch for Linux v2.2.x
Message-ID: <20001217023623.R3199@cadcamlab.org>
In-Reply-To: <000001c064c4$44c1e7e0$67bc19cb@default>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000001c064c4$44c1e7e0$67bc19cb@default>; from johnf@whitsunday.net.au on Wed, Dec 13, 2000 at 03:18:19PM +1000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[John Fort]
> It is only needed if you build your v2.2.x kernel for the Initio
> 1060p LVD SCSI controller using a later compiler than 2.7.2.3 and
> then are stupid enough to ignore any compiler warnings about
> 'ambiguous else, suggest using braces'.

You mean gcc 2.7.2.3 actually gives you the *other* meaning for that
wrong construction?  That is too weird.  The C standard is clear,
'else' always goes with the immediately preceding 'if' statement.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
