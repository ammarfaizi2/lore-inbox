Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272743AbTHPLCK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 07:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272748AbTHPLCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 07:02:10 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:9989 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272743AbTHPLCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 07:02:08 -0400
Subject: Re: increased verbosity in dmesg
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: gene.heskett@verizon.net
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308160438.59489.gene.heskett@verizon.net>
References: <200308160438.59489.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1061031726.623.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 16 Aug 2003 13:02:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-16 at 10:38, Gene Heskett wrote:

> I understand this 'ring' buffer has been expanded to about 16k but 
> that was way back in 2.1 days when that occured according to the 
> Documentation.

In 2.6.0-test, the ring bugger size is configurable. Just look for
CONFIG_LOG_BUF_SHIFT. The kernel ring size will be
2^CONFIG_LOG_BUF_SHIFT bytes, so for a CONFIG_LOG_BUF_SHIFT of 14,
you'll 2^14 or 16 KBytes.

