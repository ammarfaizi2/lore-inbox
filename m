Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317370AbSFLXSE>; Wed, 12 Jun 2002 19:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSFLXSD>; Wed, 12 Jun 2002 19:18:03 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:19930 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317370AbSFLXSC> convert rfc822-to-8bit; Wed, 12 Jun 2002 19:18:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Thu, 13 Jun 2002 01:17:48 +0200
User-Agent: KMail/1.4.1
Cc: david-b@pacbell.net, roland@topspin.com, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <52zny049r7.fsf@topspin.com> <200206122158.55375.oliver@neukum.name> <20020612.155123.116838674.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206130117.48399.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 13. Juni 2002 00:51 schrieb David S. Miller:
>    From: Oliver Neukum <oliver@neukum.name>
>    Date: Wed, 12 Jun 2002 21:58:55 +0200
>
>    Perhaps I might point out that we need a solution for 2.4.
>
> For 2.4.x just do the DMA alignment macro idea.  That would
> be the easiest change to verify.

OK, there we have something to work on.
Apart from the drivers I've already mailed, struct scsi_cmnd
is affected. kmalloc might be a problem.

Could we agree on a name for the macro ?

	Regards
		Oliver


