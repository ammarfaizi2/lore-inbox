Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSEQLMZ>; Fri, 17 May 2002 07:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315595AbSEQLMY>; Fri, 17 May 2002 07:12:24 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:2570 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S315593AbSEQLMX>; Fri, 17 May 2002 07:12:23 -0400
Date: Fri, 17 May 2002 15:11:54 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@mandrakesoft.com, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
Message-ID: <20020517151154.B16767@jurassic.park.msu.ru>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7E45@orsmsx111.jf.intel.com> <3CE4098E.2070808@mandrakesoft.com> <20020517144755.A16767@jurassic.park.msu.ru> <20020517.034048.34092752.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 03:40:48AM -0700, David S. Miller wrote:
> That is an insufficient way to determine this.  Maybe I can make two
> PCI devices talk to each other transparently between two domains
> using an IOMMU?

Hmm, not sure. I think it's impossible at least on alpha.
In either case I don't see how "struct pci_domain" etc.
could help in this case. Probably you'll need some mapping
function with pdev1, pdev2 as arguments...

Ivan.
