Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUBEPjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 10:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUBEPjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 10:39:12 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:44673 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S265210AbUBEPjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 10:39:10 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16418.25494.327896.561787@jik.kamens.brookline.ma.us>
Date: Thu, 5 Feb 2004 10:39:02 -0500
To: Joost Witteveen <joostje@foko.komputilo.org>
Cc: sschu@informatik.uni-bremen.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA BadCRC, cables exchanged, problem resists, any idea?
In-Reply-To: <slrnc24ne6.1nu.joostje@foko.komputilo.org>
References: <20040204211338.GA31768@x20.informatik.uni-bremen.de>
	<slrnc24ne6.1nu.joostje@foko.komputilo.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joost Witteveen writes:
 > > hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
 > > hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
 > 
 > Looks like the problem mentioned in
 > 
 > http://www.ussg.iu.edu/hypermail/linux/kernel/0401.2/0111.html

No, that's a different problem.

I had to replace my IDE controller to make the BadCRC errors I was
getting go away (the jury's still out on why my machine is hanging
pretty frequently with the new controller; I've made some progress at
figuring that out, and I'll post more to the list when I've got
something definite).

  jik
