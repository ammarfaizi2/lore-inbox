Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265345AbRF0SPX>; Wed, 27 Jun 2001 14:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265343AbRF0SPO>; Wed, 27 Jun 2001 14:15:14 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:63504 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265339AbRF0SOX>; Wed, 27 Jun 2001 14:14:23 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] User chroot
Date: 27 Jun 2001 11:14:13 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9hd7pl$86f$1@cesium.transmeta.com>
In-Reply-To: <20010627014534.B2654@ondska> <83fdx$Z1w-B@khms.westfalen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <83fdx$Z1w-B@khms.westfalen.de>
By author:    kaih@khms.westfalen.de (Kai Henningsen)
In newsgroup: linux.dev.kernel
>
> jc@lysator.liu.se (Jorgen Cederlof)  wrote on 27.06.01 in <20010627014534.B2654@ondska>:
> 
> > If we only allow user chroots for processes that have never been
> > chrooted before, and if the suid/sgid bits won't have any effect under
> > the new root, it should be perfectly safe to allow any user to chroot.
> 
> Hmm. Dos this work with initrd and root pivoting?
> 

At the moment, yes.  Once Viro gets his root-changes in, this breaks,
since ALL processes will be chrooted.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
