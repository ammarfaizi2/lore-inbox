Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTHSSxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbTHSSmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:42:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45452 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272309AbTHSS2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:28:49 -0400
Date: Tue, 19 Aug 2003 11:21:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: Richard Underwood <richard@aspectgroup.co.uk>
Cc: skraw@ithnet.com, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819112103.373fce27.davem@redhat.com>
In-Reply-To: <353568DCBAE06148B70767C1B1A93E625EAB5D@post.pc.aspectgroup.co.uk>
References: <353568DCBAE06148B70767C1B1A93E625EAB5D@post.pc.aspectgroup.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 19:05:13 +0100
Richard Underwood <richard@aspectgroup.co.uk> wrote:

> 	The ARP request represents all FUTURE
> packets being sent out that interface, not just the one single packet that
> happened to kick of this ARP request.

That's RIGHT!  And by your own argument the source address
in the ARP request IS IRRELEVANT and is to be ignored!

Ok, I've lost 3 days of talking about ARP non-stop, I think
I'll take a break from these threads for a while, it's getting
to be a bit much.
