Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136560AbREGS0I>; Mon, 7 May 2001 14:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136572AbREGSZv>; Mon, 7 May 2001 14:25:51 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:16649 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S136560AbREGSZ3>; Mon, 7 May 2001 14:25:29 -0400
Date: Mon, 7 May 2001 11:25:28 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <alexander.eichhorn@rz.tu-ilmenau.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Explanation of zero-copy networking
In-Reply-To: <Pine.LNX.3.95.1010507121212.4256A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0105071124080.10009-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001, Richard B. Johnson wrote:

> when the hardware I/O is used. This shows that the network code, alone,
> cannot be improved very much to provide an improvement in throughput.

doesn't your analysis assume that we've got nothing else interesting to do
while doing the network i/o?  for example, i may want to do something else
which needs the memory bandwidth i'd otherwise spend on a single-copy...

-dean

