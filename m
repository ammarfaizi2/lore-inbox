Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269857AbUIDJwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269857AbUIDJwF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269867AbUIDJwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:52:04 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:262 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269865AbUIDJuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:50:55 -0400
Date: Sat, 4 Sep 2004 10:50:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Dave Airlie <airlied@linux.ie>, Christoph Hellwig <hch@infradead.org>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904105045.A13465@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>,
	Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <Pine.LNX.4.58.0409041031370.25475@skynet> <1094291327.2801.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1094291327.2801.3.camel@laptop.fenrus.com>; from arjanv@redhat.com on Sat, Sep 04, 2004 at 11:48:47AM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 11:48:47AM +0200, Arjan van de Ven wrote:
> > true but the DRM isn't only about the Linux kernel, the DRM is a lowlevel
> > component of a much larger system, of which the DRM just has to reside in
> > the kernel,
> 
> 
> you seem to be confusing 2 things.
> 
> The kernel<->userspace interface is supposed to be stable, and it should
> be so that you can basically decouple X and kernel versions.
> 
> Within the kernel you should go for the best interface (where "best" is
> a notion that is flexible over time) because 1) you can and 2) you are
> suboptimal in both performance and maintenance if you don't

seconded.

