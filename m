Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBVQlK>; Thu, 22 Feb 2001 11:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130295AbRBVQlA>; Thu, 22 Feb 2001 11:41:00 -0500
Received: from kxmail.berlin.de ([195.243.105.30]:53636 "EHLO kxmail.berlin.de")
	by vger.kernel.org with ESMTP id <S129066AbRBVQko>;
	Thu, 22 Feb 2001 11:40:44 -0500
Message-ID: <3A95409D.85E89D95@berlin.de>
Date: Thu, 22 Feb 2001 17:38:53 +0100
From: Norbert Roos <n.roos@berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Baumann <baumann@kip.uni-heidelberg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with DMA buffer (in 2.2.15)
In-Reply-To: <20010222172458.A9717@kip.uni-heidelberg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Baumann wrote:

> is to do this in steps of PAGE_SIZE. What I'm looking for is a kernel routine
> to force the mapping of previous unmapped pages. Browsing through the source
> in mm/ I found make_pages_present(). Could this be the solution? I hadn't the

Have you already looked at mlock(2)?

Norbert
