Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTHTFdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 01:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTHTFdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 01:33:13 -0400
Received: from netcore.fi ([193.94.160.1]:39951 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id S261652AbTHTFdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 01:33:10 -0400
Date: Wed, 20 Aug 2003 08:31:31 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: "David S. Miller" <davem@redhat.com>
cc: Daniel Gryniewicz <dang@fprintf.net>, <alan@lxorguk.ukuu.org.uk>,
       <richard@aspectgroup.co.uk>, <skraw@ithnet.com>, <willy@w.ods.org>,
       <carlosev@newipnet.com>, <lamont@scriptkiddie.org>, <davidsen@tmr.com>,
       <bloemsaa@xs4all.nl>, <marcelo@conectiva.com.br>, <netdev@oss.sgi.com>,
       <linux-net@vger.kernel.org>, <layes@loran.com>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: ARP and knowledge of IP addresses [Re: [2.4 PATCH] bugfix: ARP
 respond on all devices]
In-Reply-To: <20030819112912.359eaea6.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0308200828010.32417-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, David S. Miller wrote:
[...]
> Consider the situation logically.  When you're replying to an
> ARP, _HOW_ do you know what IP addresses are assigned to _MY_
> outgoing interfaces and _HOW_ do you know what subnets _EXIST_
> on the LAN?
> 
> The answer to both is, you'd don't know these things _EVEN_ if
> you are a router/gateway.

Maybe I'm missing something but -- isn't it perfectly valid to assume the
node *ITSELF* knows about its interfaces, IP addresses, and its routes?
(Certainly, it can't know of what subnets exist on the LAN if those
haven't been configured on the node, e.g. in the form of an "interface
routes".)

ARP could look it up.

Sure, it would seem a bit like an OSI layering violation, but that's no 
news as OSI layering isn't strict anyway and has been shredded to pieces 
already in many other places.

-- 
Pekka Savola                 "You each name yourselves king, yet the
Netcore Oy                    kingdom bleeds."
Systems. Networks. Security. -- George R.R. Martin: A Clash of Kings

