Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTDIQbs (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263556AbTDIQbs (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:31:48 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:29641 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S263448AbTDIQbq (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 12:31:46 -0400
Date: Wed, 9 Apr 2003 18:03:27 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] compatmac is not needed
Message-ID: <20030409180327.K626@nightmaster.csn.tu-chemnitz.de>
References: <200304081725.h38HPeSV012611@hera.kernel.org> <1049877554.31462.24.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1049877554.31462.24.camel@passion.cambridge.redhat.com>; from dwmw2@infradead.org on Wed, Apr 09, 2003 at 09:39:15AM +0100
X-Spam-Score: -32.5 (--------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *193IfV-0003A6-00*SS87xs9vx2.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 09:39:15AM +0100, David Woodhouse wrote:
> On Tue, 2003-04-08 at 17:42, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1089, 2003/04/08 09:42:06-07:00, alan@lxorguk.ukuu.org.uk
> > 
> > 	[PATCH] compatmac is not needed
> 
> So compatmac.h ends up _empty_ in the latest kernel, but that doesn't
> mean it's not needed.
> 
> Please don't break stuff just for the sake of it.

So this is still a valid API? Good to know.

What I don't know: Can it be product specific? So the net people
ship a version for new networking APIs and filesystem people ship
new filesystem methods along with their filesystem support.

Reason I ask: There are many such frameworks floating around, but
none was complete. Many miss BUG_ON(), likely()/unlikely(),
seq_file support and many more interesting stuff.

Regards

Ingo Oeser
-- 
Marketing ist die Kunst, Leuten Sachen zu verkaufen, die sie
nicht brauchen, mit Geld, was sie nicht haben, um Leute zu
beeindrucken, die sie nicht moegen.
