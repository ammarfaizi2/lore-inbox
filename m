Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265813AbTFXOzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 10:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbTFXOzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 10:55:50 -0400
Received: from smtp4.cern.ch ([137.138.131.165]:60337 "EHLO smtp4.cern.ch")
	by vger.kernel.org with ESMTP id S266227AbTFXOzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 10:55:47 -0400
Date: Tue, 24 Jun 2003 13:47:34 +0200
From: KELEMEN Peter <Peter.Kelemen@cern.ch>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS performance ...
Message-ID: <20030624114734.GA577@chihiro.cern.ch>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <200211241521.09981.m.c.p@wolk-project.de> <20021128110627.GD26875@chiara.elte.hu> <shs65uh1wch.fsf@charged.uio.no> <20021128213612.GB6321@chiara.elte.hu> <shsznrs98di.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <shsznrs98di.fsf@charged.uio.no>
Organization: CERN European Laboratory for Particle Physics, Switzerland
X-GPG-KeyID: 1024D/EE4C26E8 2000-03-20
X-GPG-Fingerprint: D402 4AF3 7488 165B CC34  4147 7F0C D922 EE4C 26E8
X-PGP-KeyID: 1024/45F83E45 1998/04/04
X-PGP-Fingerprint: 26 87 63 4B 07 28 1F AD  6D AA B5 8A D6 03 0F BF
X-Comment: Personal opinion.  Paragraphs might have been reformatted.
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Accept-Language: hu,en
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Trond Myklebust (trond.myklebust@fys.uio.no) [20021129 07:51]:

> >>>>> " " == KELEMEN Peter <fuji@elte.hu> writes:
> > 2.4.20rc2aa1 with my .config, NFS sucked.  make menuconfig,
> > turned off CONFIG_NFS_DIRECTIO, make -j2 bzImage modules
> > modules_install (no compiler errors), install kernel, lilo,
> > reboot, NFS flies.  Confirmed on other machine as well.  gcc
> > is 3.2.1 (Debian sid).  Wish to seek more input on the case?

> I'd rather see if you can reproduce it on stock 2.4.20-pre4 +
> the NFS_ALL patch. I have a strong feeling that this is
> something that is particular to the aa kernels...

I was unable to reproduce it with your patches.

Peter

-- 
    .+'''+.         .+'''+.         .+'''+.         .+'''+.         .+''
 Kelemen Péter     /       \       /       \     Peter.Kelemen@cern.ch
.+'         `+...+'         `+...+'         `+...+'         `+...+'
