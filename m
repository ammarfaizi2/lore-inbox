Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280789AbRKBSt7>; Fri, 2 Nov 2001 13:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280782AbRKBStI>; Fri, 2 Nov 2001 13:49:08 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:9988 "HELO abasin.nj.nec.com")
	by vger.kernel.org with SMTP id <S280781AbRKBSs5>;
	Fri, 2 Nov 2001 13:48:57 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15330.60050.705170.566887@abasin.nj.nec.com>
Date: Fri, 2 Nov 2001 13:48:50 -0500 (EST)
To: linux-kernel@vger.kernel.org
Cc: Daniel Phillips <phillips@bonn-fries.net>, Ben Smith <ben@google.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
In-Reply-To: <20011102181005Z16039-4784+415@humbolt.nl.linux.org>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin>
	<3BE07730.60905@google.com>
	<15330.56589.291830.542215@abasin.nj.nec.com>
	<20011102181005Z16039-4784+415@humbolt.nl.linux.org>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > Not freeing the memory is expected and normal.  The previously-mlocked file 
 > data remains cached in that memory, and even though it's not free, it's 
 > 'easily freeable' so there's no smoking gun there.  The reason the memory is 
 > freed on umount is, there's no possibility that that file data can be 
 > referenced again and it makes sense to free it up immediately.

That cool and all, but how to I free up the memory w/o umounting the
partition?

Also, I just tried 2.4.14-pre7.  It acted the same way as 2.4.13 does,
requiring the reset key to continue.

	  Sven
