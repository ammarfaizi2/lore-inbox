Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317689AbSFLMJF>; Wed, 12 Jun 2002 08:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317690AbSFLMJE>; Wed, 12 Jun 2002 08:09:04 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:55754 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317689AbSFLMJD> convert rfc822-to-8bit; Wed, 12 Jun 2002 08:09:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "David S. Miller" <davem@redhat.com>, wjhun@ayrnetworks.com
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Wed, 12 Jun 2002 14:08:26 +0200
User-Agent: KMail/1.4.1
Cc: paulus@samba.org, roland@topspin.com, linux-kernel@vger.kernel.org
In-Reply-To: <15619.9534.521209.93822@nanango.paulus.ozlabs.org> <20020610110740.B30336@ayrnetworks.com> <20020612.044759.115989376.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206121408.26897.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 12. Juni 2002 13:47 schrieb David S. Miller:
>    From: William Jhun <wjhun@ayrnetworks.com>
>    Date: Mon, 10 Jun 2002 11:07:40 -0700
>
>    On Sun, Jun 09, 2002 at 09:27:05PM -0700, David S. Miller wrote:
>    > I'm trying to specify this such that knowledge of cachelines and
>    > whatnot don't escape the arch specific code, ho hum...  Looks like
>    > that isn't possible.
>
>    Perhaps provide macros in asm/pci.h that will:
>
> You don't understand, I think.  I want to avoid the drivers doing
> any of the "align this, align that" stuff.  I want the allocation
> to do it for them, that way the code is in one place.

That means that all buffers must be allocated seperately.
Is it worth that ? How about skbuffs ?

	Regards
		Oliver

