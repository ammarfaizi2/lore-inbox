Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbULQGpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbULQGpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 01:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbULQGpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 01:45:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17107 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262750AbULQGpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 01:45:33 -0500
Date: Fri, 17 Dec 2004 01:45:05 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Patrick McHardy <kaber@trash.net>
cc: Bryan Fulton <bryan@coverity.com>, <netdev@oss.sgi.com>,
       <netfilter-devel@lists.netfilter.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Coverity] Untrusted user data in kernel
In-Reply-To: <41C26DD1.7070006@trash.net>
Message-ID: <Xine.LNX.4.44.0412170144410.12579-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004, Patrick McHardy wrote:

> James Morris wrote:
> 
> >This at least needs CAP_NET_ADMIN.
> >
> It is already checked in do_ip6t_set_ctl(). Otherwise anyone could
> replace iptables rules :)

That's what I meant, you need the capability to do anything bad :-)


- James
-- 
James Morris
<jmorris@redhat.com>


