Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbREVMMt>; Tue, 22 May 2001 08:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbREVMMj>; Tue, 22 May 2001 08:12:39 -0400
Received: from mgw-x3.nokia.com ([131.228.20.26]:44795 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S261411AbREVMM2>;
	Tue, 22 May 2001 08:12:28 -0400
Date: Tue, 22 May 2001 14:55:53 +0300
To: linux-kernel@vger.kernel.org
Subject: Re: Q about ip_local_deliver_finish
Message-ID: <20010522145553.A619@Hews1193nrc>
In-Reply-To: <20010522143407.A590@Hews1193nrc>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010522143407.A590@Hews1193nrc>; from alexey.vyskubov@nokia.com on Tue, May 22, 2001 at 02:34:07PM +0300
From: alexey.vyskubov@nokia.com (Alexey Vyskubov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I understand correctly it means that if we have two different protocols
> with the same (modulo MAX_INET_PROTOS) protocol number then
> ip_local_deliver will return the return value of ipprot->handler for the
> first protocol in the chain
> inet_protos[protocol number modulo MAX_INET_PROTOS] and *always zero* for the
> second. Why? Is it a bug or I just do not understand something?

Of course I mean the return value for protocol handler if the chain contains
only one protcol and *always zero* if the chain contains several protocols.

--
Alexey
