Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289161AbSAGKEH>; Mon, 7 Jan 2002 05:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289162AbSAGKD5>; Mon, 7 Jan 2002 05:03:57 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:57607 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S289161AbSAGKDn>; Mon, 7 Jan 2002 05:03:43 -0500
Message-ID: <3C3972D4.56F4A1E2@loewe-komp.de>
Date: Mon, 07 Jan 2002 11:05:08 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>, velco@fadata.bg
Subject: Re: [PATCH] updated version of radix-tree pagecache
In-Reply-To: <20020105171234.A25383@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig schrieb:
> 
> [please Cc velco@fadata.bg and lkml on reply]
> 
> I've just uploaded an updated version of Momchil Velikov's patch for a
> scalable pagecache using radix trees.  The patch can be found at:
> 
> It contains a number of fixed and improvements by Momchil and me.
> 

Can you sum up the advantages of this implementation?
I think it scales better on "big systems" where otherwise you end up with many
pages on the same hash?

Is it beneficial for small systems? (I think not)
