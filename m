Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131887AbRDTVYW>; Fri, 20 Apr 2001 17:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131899AbRDTVYN>; Fri, 20 Apr 2001 17:24:13 -0400
Received: from t2.redhat.com ([199.183.24.243]:34032 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131887AbRDTVYF>; Fri, 20 Apr 2001 17:24:05 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0104201440580.12186-100000@xanadu.home> 
In-Reply-To: <Pine.LNX.4.33.0104201440580.12186-100000@xanadu.home> 
To: Nicolas Pitre <nico@cam.org>
Cc: Tom Rini <trini@kernel.crashing.org>, "Eric S. Raymond" <esr@thyrsus.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>,
        lkml <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Apr 2001 22:19:08 +0100
Message-ID: <6817.987801548@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nico@cam.org said:
> Therefore it's the maintainer's job to submit coherent patches and
> accept to see inconsistent CONFIG_* references be removed from the
> official tree until further patch submission is due. 

Maybe. But you tend to include the latest MTD code in your tree, for
example, and hence the defconfigs have the new options in. Is it really
worth your time to produce separate defconfigs without it before feeding 
your changes upstream?


> Otherwise how can you distinguish between dead wood which must be
> removed and potentially valid symbols referring to code existing only
> in a remote tree?

By periodically publishing a list of the potentially-obsolete symbols as ESR
has done, and _not_ removing the ones which people speak up about. It's not
as if this is something which needs to be done more than about once a year.

--
dwmw2


