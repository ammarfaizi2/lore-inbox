Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSKCO0w>; Sun, 3 Nov 2002 09:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbSKCO0w>; Sun, 3 Nov 2002 09:26:52 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:52229 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261894AbSKCO0u>; Sun, 3 Nov 2002 09:26:50 -0500
Date: Sun, 3 Nov 2002 14:33:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
Message-ID: <20021103143320.A25170@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20021103131339.A22465@infradead.org> <Pine.GSO.4.21.0211031526050.12573-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0211031526050.12573-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Sun, Nov 03, 2002 at 03:28:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 03:28:55PM +0100, Geert Uytterhoeven wrote:
> On Sun, 3 Nov 2002, Christoph Hellwig wrote:
> > On Sun, Nov 03, 2002 at 11:46:48AM +0100, Geert Uytterhoeven wrote:
> > > NCR53C9x ESP: C99 designated initializers
> > 
> > Please move the host template to the C file instead of the header
> > if you touch it.  Having them in the header and the methods exported
> > was needed in 2.2, but that's long ago..
> 
> At your service :-)
> Except for the MIPS JAZZ driver, since SCSI_JAZZ_ESP is not actually used
> anymore, probably due to bit rot.

The patch looks fine, thanks.  Now if all scsi host driver maintainers
would do it this way.. :)

