Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287274AbSAGWWx>; Mon, 7 Jan 2002 17:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287297AbSAGWWn>; Mon, 7 Jan 2002 17:22:43 -0500
Received: from 213-98-126-44.uc.nombres.ttd.es ([213.98.126.44]:14596 "HELO
	neno.mitica") by vger.kernel.org with SMTP id <S287274AbSAGWWb>;
	Mon, 7 Jan 2002 17:22:31 -0500
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
In-Reply-To: <20020107132121.241311F6A@gtf.org>
	<E16NbYF-0001Qq-00@starship.berlin>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <E16NbYF-0001Qq-00@starship.berlin>
Date: 07 Jan 2002 21:54:03 +0100
Message-ID: <m2vgedq3v8.fsf@neno.dmz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:

Hi

daniel> Minor nit:

daniel> if (!inode->u.ext2_ip)
daniel> BUG();

daniel> You don't have to do this, if the pointer is null you will get a perfectly
daniel> fine oops.

Without nice line information :(

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
