Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTJVKbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 06:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbTJVKbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 06:31:20 -0400
Received: from rth.ninka.net ([216.101.162.244]:60557 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263472AbTJVKbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 06:31:19 -0400
Date: Wed, 22 Oct 2003 03:31:12 -0700
From: "David S. Miller" <davem@redhat.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test8 oops (ipv6 related?)
Message-Id: <20031022033112.4d8323e4.davem@redhat.com>
In-Reply-To: <20031022091300.GA27824@bytesex.org>
References: <20031022091300.GA27824@bytesex.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Oct 2003 11:13:00 +0200
Gerd Knorr <kraxel@bytesex.org> wrote:

> This is what I got on the serial console:
> 
> Unable to handle kernel paging request at 000000ff00388090 RIP:
> <ffffffff801a0042>{__memcpy+114}PML4 0

Hmmm, what platform?  I suspect something funny wrt. to this
platform rather than ipv6 as this particular code path is well
tested.
