Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbUKELaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbUKELaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 06:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUKELaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 06:30:46 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:11734 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262647AbUKELaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 06:30:39 -0500
Date: Fri, 5 Nov 2004 12:30:33 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: Matthias Andree <matthias.andree@gmx.de>, kaber@trash.net,
       netfilter-devel@lists.netfilter.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks amanda dumps
Message-ID: <20041105113033.GA10276@merlin.emma.line.org>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	kaber@trash.net, netfilter-devel@lists.netfilter.org,
	linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20041104121522.GA16547@merlin.emma.line.org> <418A7B0B.7040803@trash.net> <20041104231734.GA30029@merlin.emma.line.org> <418AC0F2.7020508@trash.net> <20041104160655.1c66b7ef.davem@davemloft.net> <20041105010427.GA2770@merlin.emma.line.org> <20041104165847.2f178d81.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104165847.2f178d81.davem@davemloft.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2004, David S. Miller wrote:

> The original ip_conntrack_amanda was correct before
> my skb_header_pointer() changes.  Patrick's patch, which
> I'll of course apply, simply reverted those changes back
> to the original code which uses the amanda_buffer for
> the UDP control stream always.

OK, thanks to both of you for handling this.

One question remains though, where is the SKB stuff documented?  "make
htmldocs" didn't elucidate me, neither did "grep -r skb_header_pointer
Documentation"

-- 
Matthias Andree
