Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWHQGtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWHQGtf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 02:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWHQGtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 02:49:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61351 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932067AbWHQGte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 02:49:34 -0400
Subject: Re: Linux 2.4.34-pre1
From: Arjan van de Ven <arjan@infradead.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Adrian Bunk <bunk@stusta.de>, Willy Tarreau <wtarreau@hera.kernel.org>,
       linux-kernel@vger.kernel.org, mtosatti@redhat.com,
       Mikael Pettersson <mikpe@it.uu.se>
In-Reply-To: <20060817051616.GB13878@1wt.eu>
References: <20060816223633.GA3421@hera.kernel.org>
	 <20060816235459.GM7813@stusta.de>  <20060817051616.GB13878@1wt.eu>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 17 Aug 2006 08:48:51 +0200
Message-Id: <1155797331.4494.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Right now, I'd prefer getting gcc 4 support than gcc 3.4, because I don't
> know if even one common distro has shipped with gcc 3.4 by default. 2.95,
> 3.0, and 3.3 have been common, and right now, 4.[01] is almost everywhere.

but most distros that ship with gcc 4 aren't capable of running a 2.4
kernel.... all the new distros greatly depend on sysfs for example, and
ntpl in glibc requires 2.6 etc etc etc. So I'm rather sceptical about
this argument.
> 
> >   Since there shouldn't be any reason for still using a 2.4 kernel
> >   except for "never change a running system",
> 
> I think that by "never change", you meant "except for regular updates".

I think that you'll find that people who run 2.4 today, if you ask them,
will say "please change as little as possible, only serious bugs and
security issues". After all the people who run 2.4 still are generally
those who resist new stuff in favor of stability of existing systems....
But maybe it's worth doing a user survey to find out what the users of
2.4 want... (and with that I mean users of the kernel.org 2.4 kernels,
people who use enterprise distro kernels don't count for this since
they'll not go to a newer released 2.4 anyway)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

