Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288693AbSADRfH>; Fri, 4 Jan 2002 12:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbSADReq>; Fri, 4 Jan 2002 12:34:46 -0500
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:47747 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S288693AbSADRe1>; Fri, 4 Jan 2002 12:34:27 -0500
Date: Fri, 04 Jan 2002 12:33:32 -0500
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>, Oleg Drokin <green@namesys.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] expanding truncate
Message-ID: <18370000.1010165612@tiny>
In-Reply-To: <Pine.GSO.4.21.0201031111130.23312-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0201031111130.23312-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, January 03, 2002 11:17:56 AM -0500 Alexander Viro
<viro@math.psu.edu> wrote:

[ expanding truncate patch ]

> 
> 	Seriously, it looks like a half-arsed and very old attempt to do common
> expanding truncate() for no-holes filesystems.  BTW, these days rlimit
> checks are done by vmtruncate().

Whoops, good point.  It was a very old and half-arsed attempt at doing
expanding truncate to no-holes filesystems (mostly the fat flavors).
reiserfs likes it because it needs to insert zero'd out indirect items for
holes.

I've got the bits to make fat use it too, the only real gain being able to
save staroffice files onto fat.

<email backlog disclaimer, ignore if already dealt with>

-chris

