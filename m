Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbTDMKde (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 06:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263416AbTDMKde (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 06:33:34 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:27520
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S262685AbTDMKdd (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 06:33:33 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: >=2.5.66 compiling errors on Alpha
References: <3E98117F.8090705@g-house.de>
	<1050213058.15082.0.camel@rth.ninka.net>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 13 Apr 2003 12:45:52 +0200
In-Reply-To: <1050213058.15082.0.camel@rth.ninka.net>
Message-ID: <yw1xfzomd6an.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> > do you need further infos to debug this?
> > compiling a kernel on this machine is very slow, i think i can't take 
> > the "BUG-HUNTING" approach.
> 
> The Alpha folks need to fix their definition of cond_syscall().
> Copying over the asm-i386/*.h definition will probably "just work".

That won't work.  There have been two (equivalent) patches posted to
this list recently.  Will someone pick them up?

-- 
Måns Rullgård
mru@users.sf.net
