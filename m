Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSF3CMQ>; Sat, 29 Jun 2002 22:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSF3CMP>; Sat, 29 Jun 2002 22:12:15 -0400
Received: from mailhost.cs.clemson.edu ([130.127.48.6]:16547 "EHLO
	cs.clemson.edu") by vger.kernel.org with ESMTP id <S314548AbSF3CMP>;
	Sat, 29 Jun 2002 22:12:15 -0400
Date: Sat, 29 Jun 2002 22:14:38 -0400 (EDT)
From: Bendi Vinaya Kumar <vbendi@cs.clemson.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Skbuff Trimming
In-Reply-To: <p73k7okm7d1.fsf@oldwotan.suse.de>
Message-ID: <Pine.GSO.4.44.0206292203060.9760-100000@noisy.cs.clemson.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

June 29, 2002

Hi,

Guess, I understand now.

__pskb_pull_tail operates on
frag_list as well, since it is
required to pull a header (completely)
into kmalloc'd area pointed to by
skb->data.

It is, however, not required of
___pskb_trim. So, frag_list, in this
case, may be avoided.

Thanks.

Regards,
Vinaya Kumar Bendi
P.S.: Kindly CC any answers/comments
      to vbendi@cs.clemson.edu.


