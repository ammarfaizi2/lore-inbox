Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129896AbRBLCSR>; Sun, 11 Feb 2001 21:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130002AbRBLCSH>; Sun, 11 Feb 2001 21:18:07 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:30729 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S129896AbRBLCSC>;
	Sun, 11 Feb 2001 21:18:02 -0500
Date: Mon, 12 Feb 2001 00:17:57 -0200
From: Rogerio Brito <rbrito@iname.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <20010212001757.C4457@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E14S01O-0004Su-00@the-village.bc.nu> <oupvgqhkn8f.fsf@pigdrop.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <oupvgqhkn8f.fsf@pigdrop.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 11 2001, Andi Kleen wrote:
> The reiserfs nfs problem in standard 2.4 is very simple -- it'll
> barf as soon as you run out of file handle/inode cache. Any workload
> that accesses enough files in parallel can trigger it.

	I'm just trying to evaluate if I should use reiserfs here or
	not: is this phenomenon that you describe above happening
	independently of whether I choose the knfsd or userspace nfsd?

	From your message, I got the impression that it would happen
	with knfsd only, but I'm just checking before I make a wrong
	decision.


	Thanks from a humble (and ignorant) network admin, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
