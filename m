Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271378AbTGQKNE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271379AbTGQKNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:13:04 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:64269 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271378AbTGQKNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:13:00 -0400
Date: Thu, 17 Jul 2003 11:27:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@suse.cz>,
       Larry McVoy <lm@work.bitmover.com>, Andrew Morton <akpm@digeo.com>,
       Daniel Phillips <phillips@arcor.de>, acme@conectiva.com.br, cw@f00f.org,
       torvalds@transmeta.com, geert@linux-m68k.org, alan@lxorguk.ukuu.org.uk,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Message-ID: <20030717112742.B18493@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jakub Jelinek <jakub@redhat.com>, Pavel Machek <pavel@suse.cz>,
	Larry McVoy <lm@work.bitmover.com>, Andrew Morton <akpm@digeo.com>,
	Daniel Phillips <phillips@arcor.de>, acme@conectiva.com.br,
	cw@f00f.org, torvalds@transmeta.com, geert@linux-m68k.org,
	alan@lxorguk.ukuu.org.uk, perex@suse.cz,
	linux-kernel@vger.kernel.org
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <20030622014345.GD10801@conectiva.com.br> <20030621191705.3c1dbb16.akpm@digeo.com> <200306221522.29653.phillips@arcor.de> <20030622103251.158691c3.akpm@digeo.com> <20030623010555.GA4302@work.bitmover.com> <20020104113205.GB1778@zaurus.ucw.cz> <20030717111805.A18449@infradead.org> <20030717062350.Q15481@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030717062350.Q15481@devserv.devel.redhat.com>; from jakub@redhat.com on Thu, Jul 17, 2003 at 06:23:50AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 06:23:50AM -0400, Jakub Jelinek wrote:
> They handle some C99 initializers, but definitely not what the
> standard mandates.

Umm, it does handle the common case of C99 struct initializers used
in the kernel.  It might not handle some cases that aren't used by
the kernel which make you right from the language lawyer perspective
but which is rather irrelevant for this discussion.

