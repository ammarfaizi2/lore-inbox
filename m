Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUIFADQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUIFADQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 20:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUIFADQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 20:03:16 -0400
Received: from the-village.bc.nu ([81.2.110.252]:23199 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267353AbUIFADK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 20:03:10 -0400
Subject: Re: multi-domain PCI and sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391040905165048798741@mail.gmail.com>
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409041527.50136.jbarnes@engr.sgi.com>
	 <9e47339104090415451c1f454f@mail.gmail.com>
	 <200409041603.56324.jbarnes@engr.sgi.com>
	 <20040905230425.GU642@parcelfarce.linux.theplanet.co.uk>
	 <9e473391040905165048798741@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094425236.2126.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Sep 2004 00:00:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-06 at 00:50, Jon Smirl wrote:
> So how do multiple root buses work? Since they are all in the same
> domain it seems like a single IO operation would go to all of the root
> bridges simultaneously. Then each root bridge matches to the address
> and decides to send the IO operation on if there is a match.

Architecture specific. Even in the PC world it varies.

Alan

