Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbTCTR2i>; Thu, 20 Mar 2003 12:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbTCTR2i>; Thu, 20 Mar 2003 12:28:38 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:1664 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id <S261338AbTCTR2h>;
	Thu, 20 Mar 2003 12:28:37 -0500
Date: Thu, 20 Mar 2003 17:39:20 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Eric Sandall <eric@sandall.us>
Cc: tigran@veritas.com, hpa@zytor.com, mirrors@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030320173920.GA2362@mail.jlokier.co.uk>
References: <3E78D0DE.307@zytor.com> <Pine.LNX.4.44.0303192107270.3901-100000@einstein31.homenet> <20030320002127.GB7887@mail.jlokier.co.uk> <43255.134.121.46.137.1048182821.squirrel@mail.sandall.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43255.134.121.46.137.1048182821.squirrel@mail.sandall.us>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandall wrote:
> Jamie Lokier said:
> <snip>
> > Which is ok of course, but then the signatures don't match any more.
> <snip>
> > -- Jamie
> 
> Why not get the signature from the .tar file, that way the compression
> method doesn't matter?  This is how Source Mage does it's checking, we
> create and md5sum (and soon GPG) signature based on the uncompressed .tar
> file.  This way, you can use any compression you want, even changing
> around the compression to your favourite one, and the signatures will
> always match.  :)

(a) I use .gz for the patches not the tar files.  But your point still applies.

(b) On something as large as a .tar, decompressing a bz2 file to check
    the signature is really quite slow, compared with checking the
    signature of the compressed file.

-- Jamie
