Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUIUMfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUIUMfh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUIUMfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:35:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:53659 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267632AbUIUMfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:35:30 -0400
X-Authenticated: #1725425
Date: Tue, 21 Sep 2004 14:36:13 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: "Rusty Russell (IBM)" <rusty@au1.ibm.com>
Cc: torvalds@osdl.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
Message-Id: <20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
In-Reply-To: <1095721742.5886.128.camel@bach>
References: <1095721742.5886.128.camel@bach>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2004 09:09:02 +1000
"Rusty Russell (IBM)" <rusty@au1.ibm.com> wrote:

> Name: Warn that ipchains and ipfwadm are going away
> Status: Trivial
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> Start off with a warning for 2.6.9, so any remaining users have a
> chance to migrate.  Their firewall scripts might not check return
> values, and they might get a nasty surprise when this goes away.

Isn't a compile-time warning a bit "soft"? Especially when compilation of
a kernel easily produces > 100 warnings, as it does right now.

Regards
