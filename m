Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWFQVWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWFQVWO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 17:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWFQVWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 17:22:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7916 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750921AbWFQVWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 17:22:13 -0400
Subject: Re: header cleanup and install
From: David Woodhouse <dwmw2@infradead.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200606172135.22944.s0348365@sms.ed.ac.uk>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <20060605110928.35110000.akpm@osdl.org>
	 <1149535171.30024.157.camel@pmac.infradead.org>
	 <200606172135.22944.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Sat, 17 Jun 2006 22:20:57 +0100
Message-Id: <1150579258.2584.22.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-17 at 21:35 +0100, Alistair John Strachan wrote:
> > > David, we now have a mixture of "color" and "colour" in the same piece of
> > > code.  That's just dumb.
> >
> > I blame them damn Frenchies. Fixed in the git tree.
> 
> To colour, I assume. ;-) 

No, to 'color' since rb_insert_color() was the public API and hasn't
changed, while 'rb_parent_colour' is a new, internal field (now renamed
to 'rb_parent_color').

-- 
dwmw2

