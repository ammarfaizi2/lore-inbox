Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBENkL>; Mon, 5 Feb 2001 08:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129313AbRBENjw>; Mon, 5 Feb 2001 08:39:52 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:62472 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129057AbRBENjn>; Mon, 5 Feb 2001 08:39:43 -0500
Date: Mon, 5 Feb 2001 07:39:29 -0600
To: Ishikawa <ishikawa@yk.rim.or.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /usr/src/linux/scripts/ver_linux prints out incorrect info when "ls" is aliased.
Message-ID: <20010205073929.A32155@cadcamlab.org>
In-Reply-To: <3A7D7210.EA87572A@yk.rim.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A7D7210.EA87572A@yk.rim.or.jp>; from ishikawa@yk.rim.or.jp on Mon, Feb 05, 2001 at 12:15:28AM +0900
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Ishikawa]
> I just noticed that running
> 
>         .   /usr/src/linux/script/ver_linux
> 
> prints out strange libc version
[...]
> I found that if the command "ls" is aliased to "ls -aF"

So ... don't use '.' to execute scripts.  If there is some
documentation somewhere that told you to do this, please notify the
author that it is wrong.

  sh scripts/ver_linux

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
