Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144310AbRAHQAh>; Mon, 8 Jan 2001 11:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144317AbRAHQA2>; Mon, 8 Jan 2001 11:00:28 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:14027 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S144310AbRAHQAQ>; Mon, 8 Jan 2001 11:00:16 -0500
Date: Mon, 8 Jan 2001 17:59:17 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Shane Nay <shane@agendacomputing.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode
Message-ID: <20010108175917.L10035@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010108152904.K10035@nightmaster.csn.tu-chemnitz.de> <Pine.GSO.4.21.0101080836260.4061-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0101080836260.4061-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 08, 2001 at 08:42:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 08:42:35AM -0500, Alexander Viro wrote:
> If program considers these bits of st_mode as indication of ability
> to write into file - program is buggy and should be fixed. Regardless
> of cramfs.

Ok, point taken.

I fixed the generation of the tree to be crammed into the cramfs
image instead. Same code simplification without uglyfication of
the kernel ;-)

Thanks & Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
