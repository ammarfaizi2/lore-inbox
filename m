Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbTEGFNo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTEGFNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:13:44 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:51720 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262863AbTEGFNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:13:43 -0400
Date: Wed, 7 May 2003 06:26:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: dwmw2@infradead.org, thomas@horsten.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Message-ID: <20030507062613.A5318@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, dwmw2@infradead.org,
	thomas@horsten.com, linux-kernel@vger.kernel.org
References: <1052215397.983.25.camel@rth.ninka.net> <200305061510.04619.thomas@horsten.com> <1052255946.7532.66.camel@imladris.demon.co.uk> <20030506.200638.78728404.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030506.200638.78728404.davem@redhat.com>; from davem@redhat.com on Tue, May 06, 2003 at 08:06:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 08:06:38PM -0700, David S. Miller wrote:
> Listen, what do you think is the latency every time I add something
> to rtnetlink.h or pfkeyv2.h?  Should I just sit and twiddle my thumbs
> waiting for everyone to update their glibc or kernel-headers or
> whatever package before they can compile networking apps using the
> new feature?

Look at e.g. the debian and redhat packages of ipsec-tools:  they all
have their local copy of theses headers.

