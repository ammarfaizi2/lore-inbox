Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273648AbRI0QHg>; Thu, 27 Sep 2001 12:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273656AbRI0QH0>; Thu, 27 Sep 2001 12:07:26 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:4868 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273648AbRI0QHR>; Thu, 27 Sep 2001 12:07:17 -0400
Date: Thu, 27 Sep 2001 18:07:34 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Linux 0.01 disk lockup
In-Reply-To: <200109271512.f8RFCuW20065@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.3.96.1010927174821.12043A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linux 0.01 has a bug in disk request sorting - when interrupt
> > happens while sorting is active, the interrupt routine won't clear
> > do_hd - thus the disk will stay locked up forever.
> 
> Er, why bother to fix bugs in such an ancient kernel, rather than
> upgrading to a more modern kernel (like 0.98:-)? It's like finding a
> bug in 2.3.30 and fixing it rather than grabbing 2.4.10 and seeing if
> the problem persists.

Well - why not? The disk interrupt locking algorithm in 0.01 is beautiful
(except for the bug - but it can be fixed). It's something you don't see
in 2.4.10 with __cli, __sti, __save_flags, __restore_flags everywhere. So
why not to post a bug report and patch for 10th anniversary of Linux?

Mikulas




