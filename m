Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWEAXNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWEAXNQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWEAXNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:13:16 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:3266 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S932313AbWEAXNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:13:15 -0400
In-Reply-To: <adapsixs9rg.fsf@cisco.com>
References: <1906950392f7ef8c7d07.1145913778@eng-12.pathscale.com> <ada7j55vayj.fsf@cisco.com> <4B05D10C-407E-46A5-848F-0897D1E6D1CD@kernel.crashing.org> <adapsixs9rg.fsf@cisco.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <114102B4-FBCB-4A5A-B986-80D4A730DD91@kernel.crashing.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2 of 13] ipath - set up 32-bit DMA mask if 64-bit setup fails
Date: Tue, 2 May 2006 01:13:12 +0200
To: Roland Dreier <rdreier@cisco.com>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Segher> PowerPC with U3 or U4 northbridge, i.e. Maple or PowerMac
>     Segher> G5 systems.  If the IOMMU (DART) is disabled, we have a
>     Segher> 32-bit only DMA mask.  The DART will be disabled by
>     Segher> default if there is 2GB or less of memory (as it isn't
>     Segher> needed then).
>
> OK, thanks.  I was not aware of that situation.
>
> However, I suspect that PathScale has a different situation in mind,
> considering that their driver isn't even buildable for that  
> platform ;)

Well (a previous version of) that patch came from me, draw your own
conclusions :-)

And it builds just fine -- what is the problem you're thinking of?


Segher

