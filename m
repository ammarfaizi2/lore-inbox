Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267421AbTAGRAk>; Tue, 7 Jan 2003 12:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbTAGRAj>; Tue, 7 Jan 2003 12:00:39 -0500
Received: from [195.208.223.236] ([195.208.223.236]:5248 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267421AbTAGRAg>; Tue, 7 Jan 2003 12:00:36 -0500
Date: Tue, 7 Jan 2003 20:06:38 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@cup.hp.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030107200638.C559@localhost.park.msu.ru>
References: <20030105153735.A8532@jurassic.park.msu.ru> <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com> <20030106183328.B677@localhost.park.msu.ru> <20030106215210.GE26790@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030106215210.GE26790@cup.hp.com>; from grundler@cup.hp.com on Mon, Jan 06, 2003 at 01:52:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 01:52:10PM -0800, Grant Grundler wrote:
> you meant pci_scan_bus() for #1?
> 
> (pci_do_scan_bus() is the implementation, but I thought arch code
> is supposed to call pci_scan_bus().)

Of course. But hotplug stuff has to call pci_do_scan_bus directly.

Ivan.
