Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264532AbRGISed>; Mon, 9 Jul 2001 14:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264632AbRGISeX>; Mon, 9 Jul 2001 14:34:23 -0400
Received: from ns.suse.de ([213.95.15.193]:31506 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S264532AbRGISeL>;
	Mon, 9 Jul 2001 14:34:11 -0400
To: Craig Soules <soules@happyplace.pdl.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <Pine.LNX.3.96L.1010709131315.16113O-200000@happyplace.pdl.cmu.edu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 09 Jul 2001 20:33:31 +0200
In-Reply-To: Craig Soules's message of "9 Jul 2001 19:31:14 +0200"
Message-ID: <oupbsmueyv8.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Soules <soules@happyplace.pdl.cmu.edu> writes:
 
> Our system does automatic directory compaction through the use of a tree
> structure, and so the cookie needs to be invalidated.  Also, any other
> file system whicih does immediate directory compaction would require this.

Actually all the file systems who do that on Linux (JFS, XFS, reiserfs) 
have fixed the issue properly server side, by adding a layer that generates
stable cookies. You should too.

-Andi

