Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbRFBGUj>; Sat, 2 Jun 2001 02:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbRFBGU3>; Sat, 2 Jun 2001 02:20:29 -0400
Received: from idiom.com ([216.240.32.1]:37138 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S261758AbRFBGUP>;
	Sat, 2 Jun 2001 02:20:15 -0400
Message-ID: <3B188412.E3EF7736@namesys.com>
Date: Fri, 01 Jun 2001 23:13:38 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: unmount issues with 2.4.5-ac5, 3ware, and ReiserFS (was: 
 kernel-2.4.5
In-Reply-To: <Pine.GSO.4.21.0106011403330.22344-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Fri, 1 Jun 2001, Hans Reiser wrote:
> 
> > known VFS bug, ask viro for details, 2.4.5 is not stable because of it, use
> > 2.4.4
> 
> Different issue. Missing lock_kernel()/unlock_kernel() in kill_super()
> appeared in -pre6 and was fixed in -ac2 or so. -ac5 apparently had
> introduced something new, that had been reverted (fixing the problem)
> in -ac6.
thanks for clarification.

Hans
