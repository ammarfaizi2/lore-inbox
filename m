Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271813AbTGXXJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271815AbTGXXJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:09:42 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:53184 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S271813AbTGXXIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:08:44 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Michel Eyckmans (MCE)" <mce@pi.be>
Date: Fri, 25 Jul 2003 01:23:37 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.0-test1 + matroxfb = unuusable VC 
Cc: nick black <dank@suburbanjihad.net>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <82E8EE527D4@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jul 03 at 0:17, Michel Eyckmans (MCE) wrote:
> >  Anyway, can you try applying matroxfb-2.5.72.gz from 
> > ftp://platan.vc.cvut.cz/pub/linux/matrox-latest to your tree (you can
> > enable only matroxfb after patching, no other fbdev will work) and retry
> > tests?
> 
> YES! No more ghost X image, no more white rectangles, no more sudden 
> jump scrolling, and a backspace key that actually works again. Please 
> do consider pushing (some of) this to Linus for inclusion into the 
> 2.6.0.test series!

Impossible. It reverts huge parts of the fbdev API almost completely to 
the 2.4.x state, and I was already outvoted in that vote couple of 
times since January.

BTW, with my patch accented characters works correctly only on VT1.
I'm not sure how it behaves on Linus tree...

And I'm not saying that there are no bugs in the matroxfb which is in
Linus's kernel. But as nobody even answered my question I sent out on 
monday whether it is correct that FBIOGETCMAP ioctl can overwrite arbitrary 
kernel memory, I kinda lost an interest in the stock fbdev...

                                           Best regards,
                                                Petr Vandrovec

