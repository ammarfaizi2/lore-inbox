Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRALAkh>; Thu, 11 Jan 2001 19:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbRALAk0>; Thu, 11 Jan 2001 19:40:26 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14088 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129742AbRALAkJ>; Thu, 11 Jan 2001 19:40:09 -0500
Message-ID: <3A5E5248.DD7CA9AE@transmeta.com>
Date: Thu, 11 Jan 2001 16:39:36 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
CC: rdunlap <randy.dunlap@intel.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: That horrible hack from hell called A20
In-Reply-To: <Pine.LNX.4.30.0101120130350.1288-100000@vaio>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the way to go is to do the INT 15-first; possibly augmented with
a "test before even doing INT 15"...

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
