Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131152AbQLZEoO>; Mon, 25 Dec 2000 23:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131172AbQLZEoE>; Mon, 25 Dec 2000 23:44:04 -0500
Received: from natmail2.webmailer.de ([192.67.198.65]:27027 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S131152AbQLZEnx>; Mon, 25 Dec 2000 23:43:53 -0500
From: Stefan Hoffmeister <Stefan.Hoffmeister@Econos.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 8139too driver broken? (2.4-test12) - Was: Re: rtl8139 driver broken? (2.2.16)
Date: Tue, 26 Dec 2000 05:14:13 +0100
Organization: Econos
Message-ID: <g75g4tso13gl70pjbodc3mjcp9puua0q8u@4ax.com>
In-Reply-To: <vb074t8d27bdedg6m7pv4c4qqu1f8324cq@4ax.com> <E149X1l-00051k-00@the-village.bc.nu> <6kn94tohu3v901eeod2nf94ish0ct33cci@4ax.com>
In-Reply-To: <6kn94tohu3v901eeod2nf94ish0ct33cci@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: On Sat, 23 Dec 2000 18:50:53 +0100, Stefan Hoffmeister wrote:

>The rather major problem that
>remains is performance.

In case someone is interested...

Windows 2000 SP1 now has the Realtek 8139 (Celeron 433, 192 MB, pure
SCSI); drivers as shipped with W2K. Using a 40 MB test file over FTP, I
get

  Realtek card sends with 3.5 MB/s
  Realtek card receives with 5 MB/s

The system that previously contained the 8139 card now has a (10 MBit)
8029 card - transfer rates with that card are about 850 KB/s, compared to
the 400KB/s to 530 KB/s with the (100 MBit) 8139 card.

This makes me conclude that there is some pretty serious problem left in
the 8139too driver.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
