Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVANLh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVANLh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 06:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVANLh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 06:37:27 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:45573 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261957AbVANLhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 06:37:23 -0500
To: Diego Calleja <diegocg@gmail.com>
Cc: fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [fuse-devel] Merging?
References: <loom.20041231T155940-548@post.gmane.org>
	<E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu>
	<E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu>
	<20050112153131.1f778264.diegocg@gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: anything free is worth what you paid for it.
Date: Fri, 14 Jan 2005 11:37:11 +0000
In-Reply-To: <20050112153131.1f778264.diegocg@gmail.com> (Diego Calleja's
 message of "12 Jan 2005 14:32:41 -0000")
Message-ID: <87ekgo1btk.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jan 2005, Diego Calleja said:
> -Since you can use other programming languages, I suposse it'd be easier for
>  people to write support for weird filesystems.

Very weird, since the FUSE C library layer is small enough that if needs
be you can rewrite *that* in other languages as well.

I have plans for a Guile version of the userspace part of FUSE, for
instance, and some filesystems written in Guile: you certainly couldn't
do *that* in the kernel.

-- 
`Blish is clearly in love with language. Unfortunately,
 language dislikes him intensely.' --- Russ Allbery
