Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTELWIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTELWIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:08:17 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:51790 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262880AbTELWIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:08:14 -0400
Date: Mon, 12 May 2003 15:16:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eth0: vortex_error(), status=0xe081
Message-Id: <20030512151639.71bcdbbd.akpm@digeo.com>
In-Reply-To: <1052739929.793.4.camel@teapot.felipe-alfaro.com>
References: <1052739929.793.4.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2003 22:20:53.0969 (UTC) FILETIME=[C095EC10:01C318D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> eth0: vortex_error(), status=0xe081

Didn't we decide that was a tx underrun?

It could be that the polled-tx code in the pcmcia-cs package works around
it somehow.

Please test Donald Becker's driver under 2.4, from
http://www.scyld.com/network


