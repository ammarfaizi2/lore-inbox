Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752143AbWAELTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbWAELTA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbWAELTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:19:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4805 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752143AbWAELS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:18:59 -0500
Subject: Re: mm/rmap.c negative page map count BUG.
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060105111520.GL20809@redhat.com>
References: <20060103082609.GB11738@redhat.com>
	 <43BA630F.1020805@yahoo.com.au> <20060103135312.GB18060@redhat.com>
	 <20060104155326.351a9c01.akpm@osdl.org> <20060105074718.GF20809@redhat.com>
	 <1136448712.2920.4.camel@laptopd505.fenrus.org>
	 <20060105111520.GL20809@redhat.com>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 12:18:43 +0100
Message-Id: <1136459923.2920.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 06:15 -0500, Dave Jones wrote:
> On Thu, Jan 05, 2006 at 09:11:51AM +0100, Arjan van de Ven wrote:
>  > 
>  > > Quite a few Fedora users have hit it over the last year,
>  > > but what I find fascinating is that there's not a single
>  > > occurance of "BUG at mm/rmap.c" in our 2.6.9 based RHEL4 bug reports.
>  > 
>  > could mean it's caused by consumer hardware code...
> 
> Yeah. People buying enterprise distros do tend to buy branded RAM
> with goodies like ECC from big name suppliers instead of a cheap $20
> noname DIMM from "Joe's computers".
> 
> So it *could* be a lot of these are crappy hardware, especially
> as some of the reports do indicate that the problem went away
> when they upgraded their RAM.  Some of the others though, I'm
> not so sure.

it could also be some consumer-mostly device, or driver thereof. say
video capture or weird usb gizmo

