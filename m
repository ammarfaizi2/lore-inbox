Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288826AbSAEOoM>; Sat, 5 Jan 2002 09:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288827AbSAEOoB>; Sat, 5 Jan 2002 09:44:01 -0500
Received: from dsl-213-023-043-154.arcor-ip.net ([213.23.43.154]:35087 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288826AbSAEOn4>;
	Sat, 5 Jan 2002 09:43:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Date: Sat, 5 Jan 2002 15:47:02 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20011226222809.A8233@havoc.gtf.org> <5.1.0.14.2.20020105142339.03156750@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20020105142339.03156750@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Ms6L-0001Gz-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 5, 2002 03:29 pm, Anton Altaparmakov wrote:
> If anyone wants a look NTFS TNG already has gone all the way (for a while 
> now in fact). Both fs inode and super block are fs internal slab caches and 
> both use static inline NTFS_I / NTFS_SB functions and the ntfs includes 
> from linux/fs.h are removed altogether. Code is in sourceforge cvs. For 
> instructions how to download the code or to browse it online, see:

Nice, did you use the generic_ip fields?

--
Daniel
