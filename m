Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267701AbUIMRsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267701AbUIMRsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUIMRsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:48:05 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:10683 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267701AbUIMRru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:47:50 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <9e47339104091309281c4e6fb7@mail.gmail.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095074778.14374.41.camel@localhost.localdomain>
	 <9e47339104091308063c394704@mail.gmail.com>
	 <1095087860.14582.37.camel@localhost.localdomain>
	 <9e47339104091309281c4e6fb7@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095093816.14586.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Sep 2004 17:43:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-13 at 17:28, Jon Smirl wrote:
> Doesn't the base platform need to be designed to also treat individual
> heads as resources?

Already covered - although at the moment the question is open about who
tells the vga generic code "It has 4 heads" ?

Had a look over your class code - its nice and it should integrate
really easily as well as remove most of the PCI layer patching it now
does.

Alan

