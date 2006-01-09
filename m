Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWAIX7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWAIX7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 18:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbWAIX7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 18:59:24 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:45757
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751659AbWAIX7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 18:59:22 -0500
Date: Mon, 09 Jan 2006 15:54:53 -0800 (PST)
Message-Id: <20060109.155453.02785248.davem@davemloft.net>
To: kaber@trash.net
Cc: dev@openvz.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dim@sw.ru, st@sw.ru,
       netdev@vger.kernel.org
Subject: Re: [PATCH] netlink oops fix due to incorrect error code
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43C2F6DC.7040602@trash.net>
References: <43C27662.2030400@openvz.org>
	<43C2F6DC.7040602@trash.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Tue, 10 Jan 2006 00:50:52 +0100

> Kirill Korotaev wrote:
> > Fixed oops after failed netlink socket creation.
> > Wrong parathenses in if() statement caused err to be 1,
> > instead of negative value.
> > Trivial fix, not trivial to find though.
> > 
> > Signed-Off-By: Dmitry Mishin <dim@sw.ru>
> > Signed-Off-By: Kirill Korotaev <dev@openvz.org>
> 
> Good catch. Dave, please apply.

Already in Linus's tree, he applied it directly :-)
