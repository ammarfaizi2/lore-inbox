Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281042AbRKTLwD>; Tue, 20 Nov 2001 06:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281040AbRKTLvx>; Tue, 20 Nov 2001 06:51:53 -0500
Received: from ns.caldera.de ([212.34.180.1]:43984 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S281034AbRKTLvk>;
	Tue, 20 Nov 2001 06:51:40 -0500
Date: Tue, 20 Nov 2001 12:48:15 +0100
Message-Id: <200111201148.fAKBmFZ10734@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: kishore@cse.iitb.ac.in (N S S Kishore K)
Cc: linux-kernel@vger.kernel.org
Subject: Re: write_lock_bh()
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20011120170458.A24330@cse.iitb.ac.in>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011120170458.A24330@cse.iitb.ac.in> you wrote:
> hi
> 	Can I call write_lock_bh() on a different lock, from a routine
> which already called write_lock_bh() on another lock?

Just use write_lock() the second time.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
