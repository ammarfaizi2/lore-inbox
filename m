Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSHaNYV>; Sat, 31 Aug 2002 09:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSHaNYV>; Sat, 31 Aug 2002 09:24:21 -0400
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:42431 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S314546AbSHaNYU>; Sat, 31 Aug 2002 09:24:20 -0400
Date: Sat, 31 Aug 2002 15:28:43 +0200 (CEST)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@ultra60
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues
In-Reply-To: <20020827231625.A7961@infradead.org>
Message-ID: <Pine.GSO.4.40.0208311516100.7165-100000@ultra60>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 27 Aug 2002, Christoph Hellwig wrote:
> The multiplexer syscall is horribly ugly. I'd suggest implementing it
> as filesystems so each message queue object can be represented as file,
> using defined file methods as much as possible.

It seems clever. In fact previous version used file representation in
very simple and rather undesirable way so we resigned from it. But we
can try to change it.

BTW two questions: who is IPC maintainer? Are there any chances to
incorporate mqueues into kernel?

Krzysztof Benedyczak

