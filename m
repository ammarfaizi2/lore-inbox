Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131229AbQKXOT1>; Fri, 24 Nov 2000 09:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130766AbQKXOTU>; Fri, 24 Nov 2000 09:19:20 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:19138 "EHLO harpo.it.uu.se")
        by vger.kernel.org with ESMTP id <S130792AbQKXNfl>;
        Fri, 24 Nov 2000 08:35:41 -0500
Date: Fri, 24 Nov 2000 14:04:37 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200011241304.OAA21196@harpo.it.uu.se>
To: Andries.Brouwer@cwi.nl, jakub@redhat.com
Subject: Re: gcc-2.95.2-51 is buggy
Cc: alan@lxorguk.ukuu.org.uk, bernds@redhat.com, greg@linuxpower.cx,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Jakub Jelinek wrote:

>so the reason why it did not show up in the gcc you picked up from
>ftp.gnu.org is that you have compiled it so that it defaults to -mcpu=i686
>where the bug does not show up.

Indeed. I just ran some tests, and I can confirm that gcc 2.95.2 vanilla
exhibits the bug when compiled and run for i486 or i585, but not i686.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
