Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbUL1Hd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUL1Hd5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 02:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbUL1HYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 02:24:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60617 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262105AbUL1GCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 01:02:46 -0500
Date: Tue, 28 Dec 2004 01:01:48 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, Patrick McHardy <kaber@trash.net>,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: PATCH: kmalloc packet slab
Message-ID: <20041228060148.GB5481@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Patrick McHardy <kaber@trash.net>, torvalds@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
References: <1104156983.20944.25.camel@localhost.localdomain> <41D043AC.2070203@trash.net> <20041227142350.1cf444fe.davem@davemloft.net> <1104195085.20898.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104195085.20898.62.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2004 at 12:51:28AM +0000, Alan Cox wrote:
 > On Llu, 2004-12-27 at 22:23, David S. Miller wrote:
 > > If we are really going to do something like this, it should
 > > be calculated properly and be determined per-interface
 > > type as netdevs are registered.
 > 
 > Fine by me, I'm just going through plausible looking changes in the Red
 > Hat tree. You might want to slightly injure someone internally until
 > they drop that too 8)

Internal injuries unnecessary. Regardless of outcome of this patch,
Fedora will pick up whatever happens upstream instead of carrying
this any longer. This and a few other patches have been stagnating
in our tree for far longer than they should have been.

		Dave

