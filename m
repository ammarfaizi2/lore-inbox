Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264862AbTFERYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 13:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264865AbTFERYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 13:24:34 -0400
Received: from holomorphy.com ([66.224.33.161]:6842 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264862AbTFERYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 13:24:32 -0400
Date: Thu, 5 Jun 2003 10:36:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>, bcollins@debian.org,
       tom_gall@vnet.ibm.com, Anton Blanchard <anton@samba.org>
Subject: Re: /proc/bus/pci
Message-ID: <20030605173657.GA8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@redhat.com>, bcollins@debian.org,
	tom_gall@vnet.ibm.com, Anton Blanchard <anton@samba.org>
References: <1054816598.22103.6151.camel@cube> <Pine.LNX.4.44.0306050847410.9939-100000@home.transmeta.com> <20030605160007.GZ8978@holomorphy.com> <1054833800.813.43.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054833800.813.43.camel@gaston>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> I've never seen this; however, I've seen "PCI segment" used in some
>> Intel docs. I do agree that neither "phb" nor "hose" are particularly
>> nice nomenclature.

On Thu, Jun 05, 2003 at 07:23:21PM +0200, Benjamin Herrenschmidt wrote:
> imho, calling a domain a "segment" is plain wrong, I'd rather call
> "segment" a single electrical PCI bus ...
> Note: I'm to blame for polluting ppc32 with the "hose" name in
> variable/function names =P

I wouldn't particularly advocate segment over anything, I've merely
seen it used. I think we're all happy with "domain" (and are more
concerned with the functional issues anyway).


-- wli
