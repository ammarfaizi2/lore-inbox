Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292674AbSCMH5p>; Wed, 13 Mar 2002 02:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292681AbSCMH5e>; Wed, 13 Mar 2002 02:57:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26884 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292674AbSCMH5W>;
	Wed, 13 Mar 2002 02:57:22 -0500
Message-ID: <3C8F05EF.F958B07C@zip.com.au>
Date: Tue, 12 Mar 2002 23:55:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: wli@holomorphy.com, wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312070645.X10413@dualathlon.random> <20020312112900.A14628@holomorphy.com> <20020312135605.P25226@dualathlon.random> <20020312141439.C14628@holomorphy.com> <20020312160430.W25226@dualathlon.random>, <20020312160430.W25226@dualathlon.random>; <20020312233117.E14628@holomorphy.com> <3C8E98B2.159FA546@zip.com.au>,
		<3C8E98B2.159FA546@zip.com.au> <20020313083055.D21589@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> What do you think about this patch against 2.4.19pre3aa1?

Well it won't apply on 10_vm-30, but that's OK...

So BH_Launder is set when we start I/O and is cleared on
I/O completion.   That sounds fine - clearly it is always
safe to throttle on these buffers.

Thanks - I'll stress-test it tomorrow.
 
-
