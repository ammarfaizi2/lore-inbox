Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJDTN>; Tue, 9 Jan 2001 22:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbRAJDTD>; Tue, 9 Jan 2001 22:19:03 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:57612 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129431AbRAJDSy>; Tue, 9 Jan 2001 22:18:54 -0500
Date: Tue, 9 Jan 2001 19:18:53 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "David S. Miller" <davem@redhat.com>
cc: <mingo@elte.hu>, <riel@conectiva.com.br>, <hch@caldera.de>,
        <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: storage over IP (was Re: [PLEASE-TESTME] Zerocopy networking
 patch, 2.4.0-1)
In-Reply-To: <200101100258.SAA16505@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101091916210.10428-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, David S. Miller wrote:

>    Date: Tue, 9 Jan 2001 18:56:33 -0800 (PST)
>    From: dean gaudet <dean-list-linux-kernel@arctic.org>
>
>    is NFS receive single copy today?
>
> With the zerocopy patches, NFS client receive is "single cpu copy" if
> that's what you mean.

yeah sorry, i meant:

- NIC DMAs packet to memory
- CPU reads headers from memory, figures out it's NFS
- CPU copies data bytes from packet image in memory to pagecache

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
