Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315469AbSECL2k>; Fri, 3 May 2002 07:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315494AbSECL2j>; Fri, 3 May 2002 07:28:39 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31330 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315469AbSECL2i>; Fri, 3 May 2002 07:28:38 -0400
Date: Fri, 3 May 2002 13:27:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503132734.V11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random> <20020502171655.GJ32767@holomorphy.com> <20020502204136.M11414@dualathlon.random> <20020502191903.GL32767@holomorphy.com> <20020503080433.R11414@dualathlon.random> <20020503092426.GH24506@holomorphy.com> <20020503123009.P11414@dualathlon.random> <20020503110950.GI24506@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 04:09:51AM -0700, William Lee Irwin III wrote:
> page. A clean, perhaps even mergeable design for this would be a great
> boon to all users of larger highmem systems. IIRC buffer_heads were the
> specific reported problem, and though they themselves consume excessive

bh problems should be fixed with my latest vm updates, while it's nice
to cache the bh across multiple writes, it's not a big problem having to ask
the fs again to translate from logical to physical so dropping bh
aggressively when needed is ok and the right thing to do.

> Andrea, it might also be helpful to hear your input during the LSE
> conference call tomorrow. The topic is KVA exhaustion scenarios, which
> seem to be of interest to you as well.

ok.

Andrea
