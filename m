Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282904AbRL0Wob>; Thu, 27 Dec 2001 17:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282962AbRL0WoW>; Thu, 27 Dec 2001 17:44:22 -0500
Received: from ns.suse.de ([213.95.15.193]:2567 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282904AbRL0WoN>;
	Thu, 27 Dec 2001 17:44:13 -0500
Date: Thu, 27 Dec 2001 23:44:12 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Steven Walter <srwalter@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
In-Reply-To: <20011227202345.B30930@conectiva.com.br>
Message-ID: <Pine.LNX.4.33.0112272332540.15706-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Arnaldo Carvalho de Melo wrote:

> > Patch is against kernel 2.4.17, should apply to 2.5 as well.
> Good job! But please consider splitting the patch per driver and sending it
> to the respective maintainers.

Someone with far too much time on their hands would be my personal
hero[*] if they were to write a script (in language of their choice) to
parse a diff, extract filename, and do lookup in a flat text file
to find a list of maintainers/interested parties.

Imagine a patch against devfs..

$ cclist my.devfs.patch.diff
Richard Gooch <rgooch@atnf.csiro.au>
Alexander Viro <viro@math.psu.edu>

SCNR 8-)

This 'little black book of addresses' doesn't have to be anything
wonderful, but its tedious work for someone to make the textfile
mapping the various source files to email addresses.

Someone (Alan?) suggested having something like a web interface
allowing anyone interested in any particular file to register
their interest, and get added to the cclist for that file.
Which is also a cool idea.

Dave.

[*] At least for a while. I'm fickle.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

