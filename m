Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUDFW3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264049AbUDFW3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:29:25 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:29201 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264048AbUDFW3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:29:23 -0400
Date: Wed, 7 Apr 2004 02:29:22 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Stefan Wanner <stefan.wanner@postmail.ch>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3: Parse error in traps.c on Alpha
Message-ID: <20040407022922.A841@den.park.msu.ru>
References: <3B75AEAB-8807-11D8-A1B6-000393C43976@postmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B75AEAB-8807-11D8-A1B6-000393C43976@postmail.ch>; from stefan.wanner@postmail.ch on Tue, Apr 06, 2004 at 10:16:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 10:16:05PM +0200, Stefan Wanner wrote:
> I still have this problem in 2.6.5
...
> > arch/alpha/kernel/traps.c: In function `opDEC_check':
> > arch/alpha/kernel/traps.c:55: parse error before `['
...
> > gcc version 2.95.4 20011002 (Debian prerelease)

This can be compiled only with gcc version >= 3.1.

Richard, should we explicitly state the minimal gcc
version requirement for 2.6 on Alpha somewhere,
or just change the opDEC inline asm to use older syntax?
To me, both ways look acceptable.

Ivan.
