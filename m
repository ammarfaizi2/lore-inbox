Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbTDIQsL (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTDIQsK (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:48:10 -0400
Received: from 237.oncolt.com ([213.86.99.237]:16874 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S263599AbTDIQsJ (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 12:48:09 -0400
Subject: Re: [PATCH] compatmac is not needed
From: David Woodhouse <dwmw2@infradead.org>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <20030409180327.K626@nightmaster.csn.tu-chemnitz.de>
References: <200304081725.h38HPeSV012611@hera.kernel.org>
	 <1049877554.31462.24.camel@passion.cambridge.redhat.com>
	 <20030409180327.K626@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain
Organization: 
Message-Id: <1049907586.31462.228.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Wed, 09 Apr 2003 17:59:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 17:03, Ingo Oeser wrote:
> So this is still a valid API? Good to know.
> 
> What I don't know: Can it be product specific? So the net people
> ship a version for new networking APIs and filesystem people ship
> new filesystem methods along with their filesystem support.
> 
> Reason I ask: There are many such frameworks floating around, but
> none was complete. Many miss BUG_ON(), likely()/unlikely(),
> seq_file support and many more interesting stuff.

Well, my copy of include/linux/mtd/compatmac.h includes just about
everything needed to get the CVS MTD code, which is meant for 2.5, to
build and work on 2.4. 

There's definitely some scope for merging the various hacks if you're so
inclined.

-- 
dwmw2

