Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTLVWCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTLVWCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:02:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:143 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264536AbTLVWCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:02:12 -0500
Date: Mon, 22 Dec 2003 14:03:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org, clemens@endorphin.org, thornber@sistina.com
Subject: Re: loop driver, device-mapper and crypto
Message-Id: <20031222140305.61823850.akpm@osdl.org>
In-Reply-To: <1072129379.5570.73.camel@leto.cs.pocnet.net>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> wrote:
>
> In 2.6 we have a device-mapper which does such things in a much more
> generic way. I've already talked to a bunch of people working on loop
> and cryptoloop (also with Clemens Fruhwirth, the cryptoloop maintainer)
> and they all agreed that device-mapper is probably the most correct way
> to go, and would be happier if the loop driver was used for files only.

I'm not a crypto-loop user, so I am not in a position to judge whether
using dm for crypto-on-disk is feature-sufficient and adequate from an
operational point of view.

It is good that Joe-and-co are OK with it and are prepared to help support
it.  If the people who _do_ use crypto-loop like the look of the feature
set and the user interface then fine.  Certainly the loop driver has a long
history of not working very well.

So.  If those-in-the-know like it then go wild.  It would be useful to get
an opinion from the distro guys too.

However I suspect that there will be a migration issue, and that we should
continue to work to get crypto-loop functioning well, plan to remove it
from 2.8, yes?
