Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbVKGRcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVKGRcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965395AbVKGRcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:32:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11536 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965056AbVKGRcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:32:07 -0500
Date: Mon, 7 Nov 2005 18:32:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Drake <dsd@gentoo.org>,
       Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ubuntu kernel tree
Message-ID: <20051107173201.GF3847@stusta.de>
References: <20051106013752.GA13368@swissdisk.com> <436E17CA.3060803@gentoo.org> <1131316729.1212.58.camel@localhost.localdomain> <436F81D1.7000100@gentoo.org> <1131383311.11265.22.camel@localhost.localdomain> <1131383144.2477.9.camel@capoeira>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131383144.2477.9.camel@capoeira>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 06:05:44PM +0100, Xavier Bestel wrote:
> On Mon, 2005-11-07 at 18:08, Alan Cox wrote:
> > On Llu, 2005-11-07 at 16:33 +0000, Daniel Drake wrote:
> > > Source RPM's will just contain a Linux kernel tree with your patches already 
> > > applied, right?
> > 
> > Of course not. Its an rpm file. RPM files contain a set of broken out
> > patches and base tar ball plus controlling rules for application. It's
> > rather more advanced than .deb sources.
> 
> That's a troll, Alan. .deb contain exactely the same things.

No, he's right.

The changes a package maintainer does in a .deb are shipped in one big 
diff containing all the differences between the pristine upstream 
sources and the tree used for building the package.

There are now ways how to arrange the patches in a way that they are 
visible as separate patches inside the unpackaged source tree used for 
building the package [1], but if all you are interested in is to get the 
patches applied against the upstream sources RPM is still superior
(even on my Debian system mc can extract the patches as if the RPM was a 
tar file).

> 	Xav

cu
Adrian

[1] that are used by a subset of the packages shipped by Debian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

