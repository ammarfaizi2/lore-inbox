Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317011AbSFKMG3>; Tue, 11 Jun 2002 08:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSFKMG2>; Tue, 11 Jun 2002 08:06:28 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:60878 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317011AbSFKMG1> convert rfc822-to-8bit; Tue, 11 Jun 2002 08:06:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Tue, 11 Jun 2002 14:06:14 +0200
User-Agent: KMail/1.4.1
Cc: roland@topspin.com, wjhun@ayrnetworks.com, paulus@samba.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020611.003625.05877183.davem@redhat.com> <200206111007.19142.oliver@neukum.name> <20020611.011525.29963495.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206111406.14274.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 11. Juni 2002 10:15 schrieb David S. Miller:
>    From: Oliver Neukum <oliver@neukum.name>
>    Date: Tue, 11 Jun 2002 10:07:19 +0200
>
>    Are there really PCI controllers which have to physically write
>    much more than is transfered ?
>
> On sparc64 the cacheline size can be either 64 or 128 bytes.
> It's a bus characteristic, so we have to get at the PCI
> controller info.

A sparc64 is unlikely to be short on memory, or is it ?
What's wrong with always aligning on 128 bytes on sparc64 ?
A runtime check would be expensive.

	Regards
		Oliver


