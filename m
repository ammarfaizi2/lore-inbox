Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRAaGq5>; Wed, 31 Jan 2001 01:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129786AbRAaGqs>; Wed, 31 Jan 2001 01:46:48 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:37133 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129737AbRAaGq3>; Wed, 31 Jan 2001 01:46:29 -0500
Date: Wed, 31 Jan 2001 00:46:05 -0600
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: I Lee Hetherington <ilh@sls.lcs.mit.edu>,
        Vaidy Sunderam <sunderam@cs.utk.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ruined boot sector on X20/W2K
Message-ID: <20010131004605.C18746@cadcamlab.org>
In-Reply-To: <3A773734.BE3D0455@sls.lcs.mit.edu> <Pine.LNX.3.95.1010130165526.7058A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.3.95.1010130165526.7058A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Jan 30, 2001 at 05:01:59PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Richard B. Johnson]
> Then, simply:
> 	cp /boot/boot.0800 /dev/whatever

Ah, but that reverts the partition table, which may have been changed
since first installing lilo.  To avoid this, just type 'lilo -U', which
does much the same thing but without touching the partition table.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
