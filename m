Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310357AbSCLEt2>; Mon, 11 Mar 2002 23:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310392AbSCLEtU>; Mon, 11 Mar 2002 23:49:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10255 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310357AbSCLEtM>;
	Mon, 11 Mar 2002 23:49:12 -0500
Message-ID: <3C8D88B4.7060508@mandrakesoft.com>
Date: Mon, 11 Mar 2002 23:48:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: "J. Dow" <jdow@earthlink.net>, Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111741310.8121-100000@home.transmeta.com> <3C8D667F.5040208@mandrakesoft.com> <01a401c1c970$aeb74110$1125a8c0@wednesday> <3C8D71AC.3080305@mandrakesoft.com> <20020312044112.GA18857@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:

>But the minute such a layer is in place, people will begin going
>straight to the sub-low-level raw device layers so they can use
>all the exciting new extended features of their XP370000 quantum
>storage array which needs the special frob-electrons command to
>make it work...
>

SCSI generic has existed for a while now :)

So this is really just catching up.  And WRT the filtering stuff, people 
are free to use the raw cmd without any filtering at all.  Your choice.

If you mean bit-banging, see my reply to Oliver (Olivier?).

Anyway, Linus's current proposal seems both sane and flexible enough. 
 And the basic infrastructure already exists to shove raw commands onto 
the request queue.

    Jeff




