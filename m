Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTFKOjo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTFKOjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:39:44 -0400
Received: from angband.namesys.com ([212.16.7.85]:35260 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262098AbTFKOjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:39:43 -0400
Date: Wed, 11 Jun 2003 18:53:25 +0400
From: Oleg Drokin <green@namesys.com>
To: szazol@e98.hu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: buffer layer error at fs/buffer.c:127
Message-ID: <20030611145325.GA21034@namesys.com>
References: <20030611131231.GA10718@bonifac.e98.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030611131231.GA10718@bonifac.e98.hu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jun 11, 2003 at 03:12:31PM +0200, szazol@e98.hu wrote:

> I found this message in dmesg:
> buffer layer error at fs/buffer.c:127
> Pass this trace through ksymoops for reporting
> Call Trace: [<c013f145>]  [<c0114898>]  [<c0114898>]  [<c018e69a>]  [<c018e730>]  [<c018e91d>]  [<c018c527>]  [<c018c98c>]  [<c017bc8e>]  [<c0192800>]  [<c017ce2d>]  [<c02631bc>]  [<c013ee28>]  [<c013d80c>]  [<c013d888>]  [<c0108d53>] 

This incorrect debugging check is already fixed in more recent kernels.

Bye,
    Oleg
