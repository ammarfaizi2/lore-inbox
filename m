Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVCHBRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVCHBRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVCHBRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 20:17:06 -0500
Received: from orb.pobox.com ([207.8.226.5]:57473 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262000AbVCHBQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 20:16:41 -0500
In-Reply-To: <422CF779.6030508@euroweb.net.mt>
References: <422CE853.8070603@euroweb.net.mt> <9b84705fe7666dfbbf1782ca85ae2ae0@pobox.com> <422CF779.6030508@euroweb.net.mt>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3fc8879e89b758404ca32cf68739698b@pobox.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Scott Feldman <sfeldma@pobox.com>
Subject: Re: Sending IP datagrams
Date: Mon, 7 Mar 2005 17:15:33 -0800
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 7, 2005, at 4:53 PM, Josef E. Galea wrote:

> AFAIK that module uses socket buffers (struct sk_buff) to send the 
> packets. I was asking whether there was another way to send the IP 
> datagrams.

Well the network device driver wants a sk_buff (hard_start_xmit) so 
you'd need to modify the network device driver to accept something else 
if you don't want to use sk_buffs.  What's wrong with sk_buffs for your 
problem?

-scott

