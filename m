Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbQLJI1X>; Sun, 10 Dec 2000 03:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbQLJI1N>; Sun, 10 Dec 2000 03:27:13 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:44296 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129688AbQLJI06>; Sun, 10 Dec 2000 03:26:58 -0500
Date: Sun, 10 Dec 2000 01:56:24 -0600
From: Peter Samuelson <peter@cadcamlab.org>
To: David Feuer <David_Feuer@brown.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapoff weird
Message-ID: <20001210015623.V6567@cadcamlab.org>
In-Reply-To: <20001209222427.A1542@bug.ucw.cz> <4.3.2.7.2.20001209174435.00aaf310@postoffice.brown.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4.3.2.7.2.20001209174435.00aaf310@postoffice.brown.edu>; from David_Feuer@brown.edu on Sat, Dec 09, 2000 at 05:46:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[David Feuer]
> Perhaps it would be good to put a check in unlink to make sure that
> this is not the last link to a swapfile.

Much better to add code to /sbin/swapon and /sbin/swapoff to set and
clear immutable bit.  Sure it only works on ext2 but how far do you
want to take this thing?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
