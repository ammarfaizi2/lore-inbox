Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129685AbQKGGpH>; Tue, 7 Nov 2000 01:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131105AbQKGGos>; Tue, 7 Nov 2000 01:44:48 -0500
Received: from 64.124.41.10.napster.com ([64.124.41.10]:2821 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S129685AbQKGGoj>; Tue, 7 Nov 2000 01:44:39 -0500
Message-ID: <3A07A4B0.A7E9D62@napster.com>
Date: Mon, 06 Nov 2000 22:44:00 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net>
Content-Type: multipart/mixed;
 boundary="------------87C93FF2C29EDCB20202DE64"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------87C93FF2C29EDCB20202DE64
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"David S. Miller" wrote:
> 
>    Date: Mon, 06 Nov 2000 22:13:23 -0800
>    From: Jordan Mendelson <jordy@napster.com>
> 
>    There is a possibility that we are hitting an upper level bandwidth
>    limit between us an our upstream provider due to a misconfiguration
>    on the other end, but this should only happen during peak time
>    (which it is not right now). It just bugs me that 2.2.16 doesn't
>    appear to have this problem.
> 
> The only thing I can do now is beg for a tcpdump from the windows95
> machine side.  Do you have the facilities necessary to obtain this?
> This would prove that it is packet drop between the two systems, for
> whatever reason, that is causing this.

Attached to this message are dumps from the windows 98 machine using
windump and the linux 2.4.0-test10. Sorry the time stamps don't match
up.


Jordan
--------------87C93FF2C29EDCB20202DE64
Content-Type: text/plain; charset=us-ascii;
 name="lin240.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lin240.log"

23:36:15.252817 209.179.194.175.1084 > 64.124.41.179.8888: S 370996:370996(0) win 8192 <mss 536,nop,nop,sackOK> (DF)
23:36:15.252891 64.124.41.179.8888 > 209.179.194.175.1084: S 3050526223:3050526223(0) ack 370997 win 5840 <mss 1460,nop,nop,sackOK> (DF)
23:36:16.159685 209.179.194.175.1084 > 64.124.41.179.8888: . ack 1 win 8576 (DF)
23:36:16.160461 209.179.194.175.1084 > 64.124.41.179.8888: . ack 1 win 65280 (DF)
23:36:16.160488 209.179.194.175.1084 > 64.124.41.179.8888: P 1:44(43) ack 1 win 65280 (DF)
23:36:16.160506 64.124.41.179.8888 > 209.179.194.175.1084: . ack 44 win 5840 (DF)
23:36:16.261533 64.124.41.179.8888 > 209.179.194.175.1084: P 1:21(20) ack 44 win 5840 (DF)
23:36:16.261669 64.124.41.179.8888 > 209.179.194.175.1084: P 21:557(536) ack 44 win 5840 (DF)
23:36:19.261055 64.124.41.179.8888 > 209.179.194.175.1084: P 1:21(20) ack 44 win 5840 (DF)
23:36:19.450762 209.179.194.175.1084 > 64.124.41.179.8888: P 44:56(12) ack 21 win 65260 (DF)
23:36:19.450788 64.124.41.179.8888 > 209.179.194.175.1084: P 21:557(536) ack 44 win 5840 (DF)
23:36:19.450820 64.124.41.179.8888 > 209.179.194.175.1084: P 557:1093(536) ack 56 win 5840 (DF)
23:36:22.281248 209.179.194.175.1084 > 64.124.41.179.8888: P 44:456(412) ack 21 win 65260 (DF)
23:36:22.281308 64.124.41.179.8888 > 209.179.194.175.1084: . ack 456 win 6432 <nop,nop, sack 1 {44:56} > (DF)
23:36:25.441061 64.124.41.179.8888 > 209.179.194.175.1084: P 21:557(536) ack 456 win 6432 (DF)
23:36:25.701796 209.179.194.175.1084 > 64.124.41.179.8888: . ack 557 win 65280 (DF)
23:36:25.701841 64.124.41.179.8888 > 209.179.194.175.1084: P 557:1093(536) ack 456 win 6432 (DF)
23:36:25.701859 64.124.41.179.8888 > 209.179.194.175.1084: P 1093:1629(536) ack 456 win 6432 (DF)
23:36:37.701091 64.124.41.179.8888 > 209.179.194.175.1084: P 557:1093(536) ack 456 win 6432 (DF)
23:36:38.026766 209.179.194.175.1084 > 64.124.41.179.8888: . ack 1093 win 65280 (DF)
23:36:38.026826 64.124.41.179.8888 > 209.179.194.175.1084: P 1093:1629(536) ack 456 win 6432 (DF)
23:36:38.026839 64.124.41.179.8888 > 209.179.194.175.1084: P 1629:1847(218) ack 456 win 6432 (DF)
23:37:02.021068 64.124.41.179.8888 > 209.179.194.175.1084: P 1093:1629(536) ack 456 win 6432 (DF)
23:37:02.328163 209.179.194.175.1084 > 64.124.41.179.8888: . ack 1629 win 65280 (DF)
23:37:02.328189 64.124.41.179.8888 > 209.179.194.175.1084: P 1629:1847(218) ack 456 win 6432 (DF)
23:37:50.321057 64.124.41.179.8888 > 209.179.194.175.1084: P 1629:1847(218) ack 456 win 6432 (DF)
23:37:50.673000 209.179.194.175.1084 > 64.124.41.179.8888: . ack 1847 win 65062 (DF)
23:37:50.673068 64.124.41.179.8888 > 209.179.194.175.1084: P 1847:1868(21) ack 456 win 6432 (DF)
23:38:00.162380 209.179.194.175.1084 > 64.124.41.179.8888: F 456:456(0) ack 1847 win 65062 (DF)
23:38:00.181055 64.124.41.179.8888 > 209.179.194.175.1084: . ack 457 win 6432 (DF)
23:38:00.187291 64.124.41.179.8888 > 209.179.194.175.1084: F 1868:1868(0) ack 457 win 6432 (DF)
23:38:00.363357 209.179.194.175.1084 > 64.124.41.179.8888: . ack 1847 win 65062 <nop,nop, sack 1 {1868:1869} > (DF)
23:39:26.671050 64.124.41.179.8888 > 209.179.194.175.1084: P 1847:1868(21) ack 457 win 6432 (DF)
23:39:26.886417 209.179.194.175.1084 > 64.124.41.179.8888: R 371453:371453(0) win 0 (DF)

--------------87C93FF2C29EDCB20202DE64
Content-Type: text/plain; charset=us-ascii;
 name="win98.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="win98.log"

22:34:34.884487 arp who-has 64.124.41.179 tell 209.179.194.175
22:34:34.889477 209.179.194.175.1084 > 64.124.41.179.8888: S 370996:370996(0) win 8192 <mss 536,nop,nop,sackOK> (DF)
22:34:35.669892 64.124.41.179.8888 > 209.179.194.175.1084: S 3050526223:3050526223(0) ack 370997 win 5840 <mss 1460,nop,nop,sackOK> (DF)
22:34:35.670624 209.179.194.175.1084 > 64.124.41.179.8888: . ack 1 win 8576 (DF)
22:34:35.670653 209.179.194.175.1084 > 64.124.41.179.8888: . ack 1 win 65280 (DF)
22:34:35.674484 209.179.194.175.1084 > 64.124.41.179.8888: P 1:44(43) ack 1 win 65280 (DF)
22:34:36.049808 64.124.41.179.8888 > 209.179.194.175.1084: . ack 44 win 5840 (DF)
22:34:36.069773 64.124.41.179.8888 > 209.179.194.175.1084: P 1:19(18) ack 44 win 5840 (DF)
22:34:36.069837 64.124.41.179.8888 > 209.179.194.175.1084: P 19:553(534) ack 44 win 5840 (DF)
22:34:39.049788 64.124.41.179.8888 > 209.179.194.175.1084: P 1:21(20) ack 44 win 5840 (DF)
22:34:39.051638 209.179.194.175.1084 > 64.124.41.179.8888: P 44:56(12) ack 21 win 65260 (DF)
22:34:39.245138 64.124.41.179.8888 > 209.179.194.175.1084: P 21:555(534) ack 44 win 5840 (DF)
22:34:39.245208 64.124.41.179.8888 > 209.179.194.175.1084: P 557:1091(534) ack 56 win 5840 (DF)
22:34:41.739438 209.179.194.175.1084 > 64.124.41.179.8888: P 44:456(412) ack 21 win 65260 (DF)
22:34:42.064811 64.124.41.179.8888 > 209.179.194.175.1084: . ack 456 win 6432 <nop,nop,sack 43360@5 43372@5> (DF)
22:34:45.224789 64.124.41.179.8888 > 209.179.194.175.1084: P 21:557(536) ack 456 win 6432 (DF)
22:34:45.339396 209.179.194.175.1084 > 64.124.41.179.8888: . ack 557 win 65280 (DF)
22:34:45.524819 64.124.41.179.8888 > 209.179.194.175.1084: P 557:1091(534) ack 456 win 6432 (DF)
22:34:45.544830 64.124.41.179.8888 > 209.179.194.175.1084: P 1091:1625(534) ack 456 win 6432 (DF)
22:34:57.508659 64.124.41.179.8888 > 209.179.194.175.1084: P 557:1093(536) ack 456 win 6432 (DF)
22:34:57.664295 209.179.194.175.1084 > 64.124.41.179.8888: . ack 1093 win 65280 (DF)
22:34:57.834842 64.124.41.179.8888 > 209.179.194.175.1084: P 1093:1627(534) ack 456 win 6432 (DF)
22:34:57.854637 64.124.41.179.8888 > 209.179.194.175.1084: P 1627:1843(216) ack 456 win 6432 (DF)
22:35:21.859406 64.124.41.179.8888 > 209.179.194.175.1084: P 1093:1629(536) ack 456 win 6432 (DF)
22:35:21.974090 209.179.194.175.1084 > 64.124.41.179.8888: . ack 1629 win 65280 (DF)
22:35:22.119319 64.124.41.179.8888 > 209.179.194.175.1084: P 1629:1845(216) ack 456 win 6432 (DF)
22:36:10.179021 64.124.41.179.8888 > 209.179.194.175.1084: P 1629:1847(218) ack 456 win 6432 (DF)
22:36:10.323454 209.179.194.175.1084 > 64.124.41.179.8888: . ack 1847 win 65062 (DF)
22:36:10.478939 64.124.41.179.8888 > 209.179.194.175.1084: P 1847:1866(19) ack 456 win 6432 (DF)
22:36:19.818615 209.179.194.175.1084 > 64.124.41.179.8888: F 456:456(0) ack 1847 win 65062 (DF)
22:36:20.003942 [|tcp] (DF)
22:36:20.004076 64.124.41.179.8888 > 209.179.194.175.1084: F 1868:1868(0) ack 457 win 6432 (DF)
22:36:20.008601 209.179.194.175.1084 > 64.124.41.179.8888: . ack 1847 win 65062 <nop,nop,sack 23899@46547 23900@46547> (DF)
22:37:46.513418 64.124.41.179.8888 > 209.179.194.175.1084: P 1847:1868(21) ack 457 win 6432 (DF)
22:37:46.517916 209.179.194.175.1084 > 64.124.41.179.8888: R 371453:371453(0) win 0 (DF)

--------------87C93FF2C29EDCB20202DE64--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
