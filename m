Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbTAGUJr>; Tue, 7 Jan 2003 15:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbTAGUJq>; Tue, 7 Jan 2003 15:09:46 -0500
Received: from palrel11.hp.com ([156.153.255.246]:10114 "HELO palrel11.hp.com")
	by vger.kernel.org with SMTP id <S267430AbTAGUJq>;
	Tue, 7 Jan 2003 15:09:46 -0500
Date: Tue, 7 Jan 2003 12:17:00 -0800
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030107201700.GB32722@cup.hp.com>
References: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com> <1041848998.666.4.camel@zion.wanadoo.fr> <20030106194513.GC26790@cup.hp.com> <20030107200537.B559@localhost.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030107200537.B559@localhost.park.msu.ru>
User-Agent: Mutt/1.4i
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 08:05:37PM +0300, Ivan Kokshaysky wrote:
> No, unless we change the API and start exporting the domain
> number (pci_controller_num) to userspace.

BTW, please don't equate PCI controller instance number with PCI Domain.

Current parisc platforms implement one PCI address space for each SBA
(System Bus Adapter). HP ZX1 (IA64) platforms are based on parisc designs.
Each SBA can have something like 8 or 16 PCI controllers below it.

thanks,
grant
