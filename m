Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316819AbSE1CIz>; Mon, 27 May 2002 22:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSE1CIz>; Mon, 27 May 2002 22:08:55 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:61844 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S316819AbSE1CIw>; Mon, 27 May 2002 22:08:52 -0400
Date: Mon, 27 May 2002 19:08:33 -0700
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <20020528020817.GD21763@nic1-pc.us.oracle.com>
In-Reply-To: <E17AaR0-0002QM-00@the-village.bc.nu> <Pine.LNX.4.33.0205221048570.23621-100000@penguin.transmeta.com> <20020522203024.GZ2035@holomorphy.com> <384590000.1022102334@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 02:18:54PM -0700, Martin J. Bligh wrote:
> If we could get the apps (well, Oracle) to co-operate, we could just use
> clone ;-) Having this transparent for shmem segments would be really nice.

Except that we fork() from different areas, eg at startup, or from the
listener process once things are up, or directly through a locally
running client etc. so it's not just using clone() and done... 

Altho we probably should have a look at it, maybe someone already did,
will check it out.

Wim

