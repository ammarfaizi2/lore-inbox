Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291775AbSCMB1R>; Tue, 12 Mar 2002 20:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291745AbSCMB1H>; Tue, 12 Mar 2002 20:27:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17937 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291759AbSCMB0v>;
	Tue, 12 Mar 2002 20:26:51 -0500
Message-ID: <3C8EAA6A.9E040BC3@zip.com.au>
Date: Tue, 12 Mar 2002 17:24:58 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: wli@holomorphy.com
CC: Andrea Arcangeli <andrea@suse.de>, wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312070645.X10413@dualathlon.random> <20020312112900.A14628@holomorphy.com> <20020312135605.P25226@dualathlon.random> <20020312141439.C14628@holomorphy.com> <20020312160430.W25226@dualathlon.random>, <20020312160430.W25226@dualathlon.random>; <20020312233117.E14628@holomorphy.com> <3C8E98B2.159FA546@zip.com.au>,
		<3C8E98B2.159FA546@zip.com.au>; from akpm@zip.com.au on Tue, Mar 12, 2002 at 04:09:22PM -0800 <20020313010652.F14628@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli@holomorphy.com wrote:
> 
> Perhaps understandably so, I'd like to take a hands-on role in
> guiding this patch into a form suitable for the mainline kernel.

The hashing changes will become the topmost (ie: last-applied) diff 
for that reason...


> This looks like a change of invariants that could generate a fair
> amount of audit work. Ugh...

In a better world, the VM wouldn't know anything at all about
these "buffer" thingies.

-
