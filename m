Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316774AbSEaUkT>; Fri, 31 May 2002 16:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316781AbSEaUkS>; Fri, 31 May 2002 16:40:18 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30064 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316774AbSEaUkR>; Fri, 31 May 2002 16:40:17 -0400
Date: Fri, 31 May 2002 22:39:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        riel@surriel.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <20020531203911.GS1172@dualathlon.random>
In-Reply-To: <E17AaR0-0002QM-00@the-village.bc.nu> <Pine.LNX.4.33.0205221048570.23621-100000@penguin.transmeta.com> <20020522203024.GZ2035@holomorphy.com> <384590000.1022102334@flay> <20020528020817.GD21763@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 07:08:33PM -0700, Wim Coekaerts wrote:
> running client etc. so it's not just using clone() and done... 

that seems a minor problem, you could still use shm and the "corner
cases" could attach to the shm as usual, but the "core" threads wouldn't
need replication of pagetables to use the shm.

Andrea
