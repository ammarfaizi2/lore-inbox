Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWEMXlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWEMXlA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 19:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWEMXlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 19:41:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31695 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964806AbWEMXk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 19:40:59 -0400
Subject: Re: [PATCH] mtd: fix memory leaks in phram_setup
From: David Woodhouse <dwmw2@infradead.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org,
       Jochen =?ISO-8859-1?Q?Sch=E4uble?= <psionic@psionic.de>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <9a8748490605131634w73b8d40ax278fac343602123b@mail.gmail.com>
References: <200605140107.18293.jesper.juhl@gmail.com>
	 <1147562300.12379.1.camel@pmac.infradead.org>
	 <9a8748490605131634w73b8d40ax278fac343602123b@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 May 2006 00:40:42 +0100
Message-Id: <1147563643.16761.1.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-14 at 01:34 +0200, Jesper Juhl wrote:
> Sure thing, will do. The same problem exists in
> drivers/mtd/devices/block2mtd.c, I'm cooking up a patch for that one
> as we speak.

OK, thanks.

> > (Ew. The parse_err() macro contains a 'return'. Who do I slap for 
> > that?)
>
> Want me to fix the macro and the users of it?

Well, the exclamation was intended to provoke Jörn or Jochen into fixing
it for themselves, but if you get there first that'd be great too :)

-- 
dwmw2

