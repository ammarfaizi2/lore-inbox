Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935817AbWK1K2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935817AbWK1K2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935815AbWK1K2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:28:13 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:62899 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S935813AbWK1K2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:28:12 -0500
Date: Tue, 28 Nov 2006 13:26:49 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
Message-ID: <20061128102649.GF15083@2ka.mipt.ru>
References: <11641265982190@2ka.mipt.ru> <456621AC.7000009@redhat.com> <20061124120531.GC32545@2ka.mipt.ru> <456B3FF2.3010908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <456B3FF2.3010908@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 28 Nov 2006 13:26:54 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 11:43:46AM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >It _IS_ how previous interface worked.
> >
> >	EXACTLY!
> 
> No, the old interface committed everything not only up to a given index. 
>  This is the huge difference which makes or breaks it.

Interface was the same - logic behind it was differnet, the only thing
required was to add consumer's index - that is all, no need to change a
lot of declarations, userspace and so on - just use existing interface
and extend its functionality. 

But it does not matter anymore, later this week I will collect all
proposed changes and implement (hopefully) last release, which will
close most of the questions regarding userspace interfaces (except
signal mask, it is in fluent state), so we could concentrate on
internals and/or new kernel users.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
