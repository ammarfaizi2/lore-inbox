Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTHSUZj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbTHSTST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:18:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36749 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261276AbTHSTRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:17:32 -0400
Date: Tue, 19 Aug 2003 12:10:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: alan@lxorguk.ukuu.org.uk, richard@aspectgroup.co.uk, skraw@ithnet.com,
       willy@w.ods.org, carlosev@newipnet.com, lamont@scriptkiddie.org,
       davidsen@tmr.com, bloemsaa@xs4all.nl, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819121003.7b5031c7.davem@redhat.com>
In-Reply-To: <1061320363.3744.14.camel@athena.fprintf.net>
References: <353568DCBAE06148B70767C1B1A93E625EAB57@post.pc.aspectgroup.co.uk>
	<1061296544.30566.8.camel@dhcp23.swansea.linux.org.uk>
	<1061317825.3744.7.camel@athena.fprintf.net>
	<20030819112912.359eaea6.davem@redhat.com>
	<1061320363.3744.14.camel@athena.fprintf.net>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Aug 2003 15:12:43 -0400
Daniel Gryniewicz <dang@fprintf.net> wrote:

> (And it's not just cisco, all the *BSDs (and therefore anything
> that took the BSD stack such as MS) work this way too.)

Not true.  Microsoft systems do respond properly to these ARPs.
