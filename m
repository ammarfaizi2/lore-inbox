Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSERChh>; Fri, 17 May 2002 22:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316631AbSERChg>; Fri, 17 May 2002 22:37:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60933 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316629AbSERChg>; Fri, 17 May 2002 22:37:36 -0400
Date: Fri, 17 May 2002 19:37:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: <E178eMm-0000NO-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0205171936220.1524-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 May 2002, Rusty Russell wrote:
>
> Sorry I wasn't clear: I'm saying *replace*, not add,

Ok, let _me_ be clear: replacing them with an inferior product that cannot
tell you partial copies is not going to happen. Not now, not ever. You
would break all the users who _require_ knowing about a read() that only
gave you 5 out of 50 bytes.

		Linus

