Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbTFERLB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 13:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbTFERLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 13:11:01 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:43770 "EHLO gaston")
	by vger.kernel.org with ESMTP id S264781AbTFERLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 13:11:00 -0400
Subject: Re: /proc/bus/pci
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>, bcollins@debian.org,
       tom_gall@vnet.ibm.com, Anton Blanchard <anton@samba.org>
In-Reply-To: <20030605160007.GZ8978@holomorphy.com>
References: <1054816598.22103.6151.camel@cube>
	 <Pine.LNX.4.44.0306050847410.9939-100000@home.transmeta.com>
	 <20030605160007.GZ8978@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054833800.813.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Jun 2003 19:23:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I've never seen this; however, I've seen "PCI segment" used in some
> Intel docs. I do agree that neither "phb" nor "hose" are particularly
> nice nomenclature.

imho, calling a domain a "segment" is plain wrong, I'd rather call
"segment" a single electrical PCI bus ...

Note: I'm to blame for polluting ppc32 with the "hose" name in
variable/function names =P

Ben.

