Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTCTVDc>; Thu, 20 Mar 2003 16:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262291AbTCTVDb>; Thu, 20 Mar 2003 16:03:31 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:58859 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S261907AbTCTVDa>; Thu, 20 Mar 2003 16:03:30 -0500
Date: Thu, 20 Mar 2003 22:14:04 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Eric Sandall <eric@sandall.us>, linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030320211404.GA410@wohnheim.fh-wedel.de>
References: <3E78D0DE.307@zytor.com> <Pine.LNX.4.44.0303192107270.3901-100000@einstein31.homenet> <20030320002127.GB7887@mail.jlokier.co.uk> <43255.134.121.46.137.1048182821.squirrel@mail.sandall.us> <20030320173920.GA2362@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030320173920.GA2362@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 March 2003 17:39:20 +0000, Jamie Lokier wrote:
> Eric Sandall wrote:
> > 
> > Why not get the signature from the .tar file, that way the compression
> > method doesn't matter?  This is how Source Mage does it's checking, we
> > create and md5sum (and soon GPG) signature based on the uncompressed .tar
> > file.  This way, you can use any compression you want, even changing
> > around the compression to your favourite one, and the signatures will
> > always match.  :)
> 
> (b) On something as large as a .tar, decompressing a bz2 file to check
>     the signature is really quite slow, compared with checking the
>     signature of the compressed file.

That shouldn't matter, most of the times. If you want to build the
code, you have to [bg]unzip anyway, so there is no extra cost.
And I have a hard time to think of a real-world application where you
don't want to unpack but need to verify the signature.

Jörn

-- 
If System.PrivateProfileString("",
"HKEY_CURRENT_USER\Software\Microsoft\Office\9.0\Word\Security", "Level") <>
"" Then  CommandBars("Macro").Controls("Security...").Enabled = False
-- from the Melissa-source
