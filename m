Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270448AbTHSPKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270472AbTHSPJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:09:48 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:39146 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S270651AbTHSPHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 11:07:54 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 19 Aug 2003 17:07:51 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: richard@aspectgroup.co.uk, alan@lxorguk.ukuu.org.uk, davem@redhat.com,
       willy@w.ods.org, carlosev@newipnet.com, lamont@scriptkiddie.org,
       davidsen@tmr.com, bloemsaa@xs4all.nl, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819170751.2b92ba2e.skraw@ithnet.com>
In-Reply-To: <20030819145403.GA3407@alpha.home.local>
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
	<20030819145403.GA3407@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 16:54:03 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> This is exactly the case I calmly discussed privately with David then Alexey.
> Both explained me that in fact, the remote host shouldn't be filtering the
> ARP requests based on the source IP they provide,

Hm, what rule is broken by the remote host, then? I mean "remote host shouln't"
reads like "according to RFC-XYZ he should not".
IFF of course the remote host is not broken, then our idea must be broken. Else
world would have kind of a definition gap in this layer of networking, and I
hardly believe that.

Regards,
Stephan
