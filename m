Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269169AbUIYBWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269169AbUIYBWO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269170AbUIYBWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:22:14 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:20722 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S269169AbUIYBWK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:22:10 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Date: Fri, 24 Sep 2004 18:21:27 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: mlock(1)
In-Reply-To: <20040925010759.GA3309@dualathlon.random>
Message-ID: <Pine.LNX.4.60.0409241819580.1341@dlang.diginsite.com>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net>
 <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random>
 <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004, Andrea Arcangeli wrote:

>
> We could use the cryptoloop or dm-crypto and everything would work fine
> if we were ok to re-run mkswap after every reboot (right after choosing
> the random password). But it sounds just simpler to leave the swap
> header in cleartext. The swap header and the swap metadata in general,
> are the only thing that can be written in cleartext safely.
>

if you don't do a -c mkswap runs fast enough that it shouldn't be a 
problem to do it every boot.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
