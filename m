Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269937AbRHEMQA>; Sun, 5 Aug 2001 08:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269946AbRHEMPv>; Sun, 5 Aug 2001 08:15:51 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:62985 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269937AbRHEMPj>; Sun, 5 Aug 2001 08:15:39 -0400
Date: Sun, 5 Aug 2001 14:15:46 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010805141546.B13438@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com>, <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org> <3B6B4B21.B68F4F87@zip.com.au>, <3B6B4B21.B68F4F87@zip.com.au> <20010804131904.E18108@weta.f00f.org> <3B6B53A9.A9923E21@zip.com.au> <20010804060423.I16516@emma1.emma.line.org> <20010805063003.B20111@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010805063003.B20111@weta.f00f.org>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Aug 2001, Chris Wedgwood wrote:

> Anyhow, if you read recent comments it looks like thre are filesystems
> which will be badly affected by placing this logic into the VFS
> (eg. Coda).  It may well be this should become a fs-specific thing
> (which sucks a little, because it makes the suggestion of tracking
> link/unlink directories ugly) and for some filesystems such as

Why does it? Each file-system is self-contained with respect to hard
links. You cannot have link cross file system boundaries.

Common code can be placed into a library. (Probably 2.5 stuff though.)

-- 
Matthias Andree
