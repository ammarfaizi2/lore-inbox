Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292595AbSBZBOy>; Mon, 25 Feb 2002 20:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292593AbSBZBOo>; Mon, 25 Feb 2002 20:14:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36621 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292594AbSBZBOa>;
	Mon, 25 Feb 2002 20:14:30 -0500
Message-ID: <3C7AE123.97A92EA0@zip.com.au>
Date: Mon, 25 Feb 2002 17:13:07 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ken Brownfield <brownfld@irridia.com>
CC: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
In-Reply-To: <200202260135.18913.Dieter.Nuetzel@hamburg.de>,
		<200202260135.18913.Dieter.Nuetzel@hamburg.de>; from Dieter.Nuetzel@hamburg.de on Tue, Feb 26, 2002 at 01:35:18AM +0100 <20020225190241.C26077@asooo.flowerfire.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Brownfield wrote:
> 
> ...
> It should be in it's own release separate from other major changes at
> least, IMHO, if the backport is desired by enough folk to outweigh the
> largish change.  And I definitely have VM _way_ higher up my personal
> list. :)
> 

I intend to chunk up the -aa VM patch and feed it into 2.4.19-pre.
I think Andrea's OK with that.   Just the VM and buffercache bits.
Something also needs to be done about block-highmem and pte-highmem.

It'll take some time - it needs to go in across several releases
so we can keep an eye on its effects, and there seem to be quite
a lot of little personal patchpiles banked up for 2.4.19.

-
