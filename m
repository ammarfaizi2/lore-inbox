Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269172AbUJENvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269172AbUJENvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269139AbUJENvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:51:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44226 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269289AbUJENuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:50:54 -0400
Date: Tue, 5 Oct 2004 09:50:44 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hideo AOKI <aoki@sdl.hitachi.co.jp>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6]  vm-thrashing-control-tuning
In-Reply-To: <4162A359.8030701@sdl.hitachi.co.jp>
Message-ID: <Pine.LNX.4.44.0410050949300.30172-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Hideo AOKI wrote:

> I am exploring tuning policy.
> 
> Any comments or suggestions?

While I believe that a self tuning timeout might be better in
the long run, this tunable will certainly help tune policy.

Besides, even with a self tuning timeout we'll want to have
this tunable visible in /proc so we can debug things by seeing
what value the kernel set the tunable to ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

