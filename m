Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129295AbQKYRB3>; Sat, 25 Nov 2000 12:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQKYRBK>; Sat, 25 Nov 2000 12:01:10 -0500
Received: from bittersweet.inetarena.com ([209.102.107.172]:13316 "HELO
        bittersweet.inetarena.com") by vger.kernel.org with SMTP
        id <S129295AbQKYRBH>; Sat, 25 Nov 2000 12:01:07 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test{8..11} CONFIG_NETLINK*=y => unresolved symbol errors in several modules
X-Face: /Q}=yl}1_v7nP)xXo5XjG8+tl@=uVu7o5u6)f]zN?+<hB!K.m9:[|*p34jVN`O;:XZXVSy>/\R>qDt(t8w!-i{(y0"`jFw^uk8inzO9wXabd'CdjUWfC\GHi:6nO*YC89#-qD>Q4r%9!V"<RYJ=7D#$";q=zML5'!=wvXk^$`6FT=5CMofQX)WUKt0p:OKl.mFOXx/D
From: karlheg@bittersweet.inetarena.com (Karl M. Hegbloom)
Date: 25 Nov 2000 00:22:15 -0800
Message-ID: <8766lc1mx4.fsf@bittersweet.intra>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Notus)
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Sorry if this is already reported; I'm not subscribed since it's way
 over my head still and there's too much else to do...  so, please CC
 me if you need more input.

 I'm goofing around trying to get the right options set so I can run
 `dhcpd' and `vtun'...  I accidently turned on the "netlink" in
 "networking options", and found that `depmod -a' mentions several
 unresolved symbol errors.  One module in particular is `ipchains.o'
 that does this.  Upon reboot and attempted `modprobe ipchains', I see
 "netlink" mentioned, IIRC.  There is conditionalization in the
 "ipchains_core.c" on whether netlink is configured in, so I think
 this is correct information.

 Hope you can find it and fix it in only a few minutes.  It will take
 me another few years to do so, I believe.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
