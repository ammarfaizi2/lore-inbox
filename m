Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbSKPPak>; Sat, 16 Nov 2002 10:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267295AbSKPPaj>; Sat, 16 Nov 2002 10:30:39 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:3263 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S267292AbSKPPai>; Sat, 16 Nov 2002 10:30:38 -0500
To: Andries.Brouwer@cwi.nl
Cc: aebr@win.tue.nl, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs stuff for eisa bus [1/3]
References: <UTC200211161343.gAGDhQI15309.aeb@smtp.cwi.nl>
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 16 Nov 2002 16:37:07 +0100
Message-ID: <wrp8yztedb0.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <UTC200211161343.gAGDhQI15309.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AB" == Andries Brouwer <Andries.Brouwer@cwi.nl> writes:

AB> This morning, just for fun, I retrieved an old *.CFG directory
AB> from the attic. Of the about 300 files, about half were not in
AB> your list. A patch is given below.

Thanks a lot.

AB> Of the ones that had an ID in your list, many mentioned different
AB> revisions or firmware etc. The NAME= given in a .CFG file belongs
AB> to that file, but not at all to the ID. This is a different
AB> argument against having such a list in the kernel source: it leads
AB> to confusion when the kernel prints an incorrect type or model
AB> number, and people will blame driver errors on the kernel
AB> "misunderstanding".

Indeed. I already cleaned up several entries myself (the AXP
ones...).

AB>     From: Alan Cox <alan@lxorguk.ukuu.org.uk>
AB>     I think a ".ids" file list is valuable. It can be used for things like
AB>     EISA card identification obviously but it also has a big value for
AB>     "lseisa" "lspnp" and friends (and hopefully when someone fixes the
AB>     device model "lsdev").

AB> Yes, lists are fine, but not in the kernel source.

Ok, I'll remove it, and will put it somewhere else.

Does someone have something to say about the code itself, specially
about the hacked drivers ? I haven't heard anything about it yet...

Thanks,

        M.
-- 
Places change, faces change. Life is so very strange.
