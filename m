Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130632AbQK1VRd>; Tue, 28 Nov 2000 16:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130779AbQK1VRX>; Tue, 28 Nov 2000 16:17:23 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:8205 "EHLO zikova.cvut.cz")
        by vger.kernel.org with ESMTP id <S130632AbQK1VRL>;
        Tue, 28 Nov 2000 16:17:11 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "David S. Miller" <davem@redhat.com>
Date: Tue, 28 Nov 2000 21:46:56 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.0-test11 ext2 fs corruption
CC: viro@math.psu.edu, linux-kernel@vger.kernel.org, tytso@valinux.com
X-mailer: Pegasus Mail v3.40
Message-ID: <E2C40AB5D29@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Nov 00 at 12:04, David S. Miller wrote:
> 
>    Yes, it is identical copy. But I do not think that hdd can write same
>    data into two places with one command...
> 
> Petr, did the af_inet.c assertions get triggered on this
> same machine?

No, ext2fs is at home, and af_inet is at work... At work I'm using
vmware, at home I do not use it... But kernel sources are same
(g450 patch for matroxfb, ncpfs supporting device nodes, threaded ipx;
but neither ncpfs nor ipx is compiled at home).
                                                   Petr Vandrovec
                                                   vandrove@vc.cvut.cz
                                                   
                                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
