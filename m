Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTK1BDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 20:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTK1BDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 20:03:52 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24224 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261776AbTK1BDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 20:03:51 -0500
Date: Thu, 27 Nov 2003 17:03:37 -0800
From: "David S. Miller" <davem@redhat.com>
To: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org,
       felix-kernel@fefe.de
Subject: Re: ipv4-mapped ipv4 connect() for UDP broken in test10
Message-Id: <20031127170337.7210df24.davem@redhat.com>
In-Reply-To: <20031127.211135.09649297.yoshfuji@linux-ipv6.org>
References: <20031126081745.GA31415@codeblau.de>
	<20031126.190407.102714104.yoshfuji@linux-ipv6.org>
	<20031127.211135.09649297.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Nov 2003 21:11:35 +0900 (JST)
YOSHIFUJI Hideaki / _$B5HF#1QL@ <yoshfuji@linux-ipv6.org> wrote:

> In article <20031126.190407.102714104.yoshfuji@linux-ipv6.org> (at Wed, 26 Nov 2003 19:04:07 +0900 (JST)), YOSHIFUJI Hideaki / _$B5HF#1QL@ <yoshfuji@linux-ipv6.org> says:
> 
> I'm sure the original code has a bug.
> I do think that it is related to your report 
> (but I don't have time to confirm it.)
> 
> s6_addr[3] should be s6_addr32[3] because the code is intended to extract 
> IPv4 address from the IPv4-mapped address (::ffff:0.0.0.0/96)
> to convert sockaddr_in6{} to sockaddr_in{}.

I know, I know.

I did apply your patch already, sorry for not telling you this.

Thanks.
