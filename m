Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbUJ0OeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbUJ0OeA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbUJ0Od5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:33:57 -0400
Received: from aun.it.uu.se ([130.238.12.36]:49335 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262461AbUJ0Odm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:33:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16767.45494.863511.334215@alkaid.it.uu.se>
Date: Wed, 27 Oct 2004 16:33:26 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: CaT <cat@zip.com.au>, torvalds@osdl.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] ide-2.6 update
In-Reply-To: <58cb370e04102706512283405@mail.gmail.com>
References: <58cb370e04102706074c20d6d7@mail.gmail.com>
	<20041027133431.GF1127@zip.com.au>
	<58cb370e04102706512283405@mail.gmail.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz writes:
 > http://bugme.osdl.org/show_bug.cgi?id=2494
 > 
 > On Wed, 27 Oct 2004 23:34:31 +1000, CaT <cat@zip.com.au> wrote:
 > > On Wed, Oct 27, 2004 at 03:07:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
 > > > <bzolnier@trik.(none)> (04/10/26 1.2192)
 > > >    [ide] pdc202xx_old: PDC20267 needs the same LBA48 fixup as PDC20265
 > > 
 > > What would the symptoms of this bug be? I've got a PDC20267 and I'm
 > > having a few issues transferring from hde to hdh (ie across two ports)
 > > it seems. My work at duplicating things seems to work best when I do a
 > > transfer like that rather then going from say, a totall different
 > > controller to the pdc (hdh) or even from generated input to the pdc (hdh).

I see only one note where someone claims the '67 is affected.
What would trigger it? A large disk or just heavy I/O?
FWIW, my news server has received, stored, manipulated, and sent >500
gigabytes of data using a lowly 20267 add-on card in a 440BX mobo,
and has _never_ had any problems, and I/O is sometimes very heavy.
