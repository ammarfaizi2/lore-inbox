Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136474AbRD3Hvv>; Mon, 30 Apr 2001 03:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136475AbRD3Hvc>; Mon, 30 Apr 2001 03:51:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16534 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136474AbRD3Hvb>;
	Mon, 30 Apr 2001 03:51:31 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15085.6528.594541.837251@pizda.ninka.net>
Date: Mon, 30 Apr 2001 00:51:28 -0700 (PDT)
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <3AED145F.84E95D8D@transmeta.com>
In-Reply-To: <3AEBF782.1911EDD2@mandrakesoft.com>
	<Pine.LNX.4.33.0104290914260.14261-100000@twinlark.arctic.org>
	<15085.3587.865614.360094@pizda.ninka.net>
	<3AED145F.84E95D8D@transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


H. Peter Anvin writes:
 > RDTSC in Crusoe processors does basically this.

Hmmm, one of the advantages of using a seperate tick register for this
constant clock is that you can still do cycle accurate asm code
analysis even when the cpu is down clocked.

The joys of compatability I suppose :-)

Later,
David S. Miller
davem@redhat.com

