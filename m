Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUJTMWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUJTMWW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270125AbUJTMV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:21:57 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:45703 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S270122AbUJTMVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:21:11 -0400
Subject: Re: iproute2 and 2.6.9 kernel headers (was Re: [ANNOUNCE] iproute2
	2.6.9-041019)
From: David Woodhouse <dwmw2@infradead.org>
To: David Vrabel <dvrabel@arcom.com>
Cc: Harald Welte <laforge@gnumonks.org>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, LARTC@mailman.ds9a.nl
In-Reply-To: <4176517C.4090504@arcom.com>
References: <41758014.4080502@osdl.org>
	 <Pine.LNX.4.61.0410200805110.8475@boston.corp.fedex.com>
	 <20041020070017.GA19899@sunbeam.de.gnumonks.org>
	 <20041020094123.GF19899@sunbeam.de.gnumonks.org>
	 <1098268885.3872.81.camel@baythorne.infradead.org>
	 <4176517C.4090504@arcom.com>
Content-Type: text/plain
Message-Id: <1098274788.3872.90.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 20 Oct 2004 13:19:48 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 12:52 +0100, David Vrabel wrote:
> David Woodhouse wrote:
> > 
> > The time has come to fix it properly instead. Anything which these tools
> > actually need from the kernel headers should be moved into a separate
> > header file (still in the kernel source) which is usable from _both_
> > kernel and userspace.
> 
> Isn't this what linux-libc-headers is for?

The separate linux-libc-headers is a hack, which will be able to die
once we properly clean up the kernel headers into those which are
'exported' and those which are private.

> > It should use standard types (like uint16_t etc)
> 
> Why doesn't the kernel use these standard types also?

Archaic personal preference. Inside the kernel that's fair enough.

-- 
dwmw2


