Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268760AbUJEDLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268760AbUJEDLa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 23:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268755AbUJEDL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 23:11:29 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:57239 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S268752AbUJEDLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 23:11:17 -0400
Date: Mon, 4 Oct 2004 23:11:08 -0400 (EDT)
From: William Knop <wknop@andrew.cmu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: libata badness
In-Reply-To: <16737.54003.419130.575839@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.60-041.0410042301510.22333@unix47.andrew.cmu.edu>
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu>
 <16737.54003.419130.575839@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This code starts:
>
>   0:   8b 55 04                  mov    0x4(%ebp),%edx
>   3:   83 c1 08                  add    $0x8,%ecx
>
> and as %ebp is 01000000, this oopses.
> It looks very much like a single-bit memory error (as has already been
> suggested as a possibility).

Oh my. So, I ran memcheck again for a few hours, and it checked out fine. 
Just in case, though, I bought a replacement stick of ram. Well, the 
oopses went away, so it must have been the ram.

Sigh. Sorry about that, everyone. I suppose the raid operations are 
particularly memory intensive. Anyway, thanks a ton for all the help.

Will
