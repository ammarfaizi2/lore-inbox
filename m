Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265641AbUABUMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265642AbUABUMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:12:22 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:3346 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265641AbUABUMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:12:15 -0500
Date: Fri, 2 Jan 2004 20:11:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20040102201138.A1124@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, akpm@osdl.org,
	davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
References: <20031228143603.A20391@infradead.org> <Pine.SGI.3.96.1031230151441.2502941C-100000@daisy-e236.americas.sgi.com> <20031230212450.A9765@infradead.org> <3FF5CADE.9010703@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FF5CADE.9010703@sgi.com>; from pfg@sgi.com on Fri, Jan 02, 2004 at 01:47:42PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 01:47:42PM -0600, Patrick Gefre wrote:
> OK - I updated the patches as Christoph suggested (removed 
> hwgraph_path_lookup() from 000, removed
> snia64_pci_find_bios() from 014, removed pcibr_businfo_get() from 030 
> and dropped 071).
> 
> I took the reorg patch (075) out for now - I am reworking it along with 
> our next set of patches.
> 
> So I think they are ready to go ?

Yes.  030 still has some really strange additions but we can back that
out later.

For the next round of patched I would be nice if you could get the
attribution of the patches right, though..

