Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273246AbRI0PNG>; Thu, 27 Sep 2001 11:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273242AbRI0PM4>; Thu, 27 Sep 2001 11:12:56 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:10722 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S273246AbRI0PMm>; Thu, 27 Sep 2001 11:12:42 -0400
Date: Thu, 27 Sep 2001 09:12:56 -0600
Message-Id: <200109271512.f8RFCuW20065@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Linux 0.01 disk lockup
In-Reply-To: <Pine.LNX.3.96.1010927150812.28147B-100000@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.3.96.1010927150812.28147B-100000@artax.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka writes:
> Linux 0.01 has a bug in disk request sorting - when interrupt
> happens while sorting is active, the interrupt routine won't clear
> do_hd - thus the disk will stay locked up forever.

Er, why bother to fix bugs in such an ancient kernel, rather than
upgrading to a more modern kernel (like 0.98:-)? It's like finding a
bug in 2.3.30 and fixing it rather than grabbing 2.4.10 and seeing if
the problem persists.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
