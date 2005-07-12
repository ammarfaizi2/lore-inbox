Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVGLE6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVGLE6f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 00:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVGLE6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 00:58:33 -0400
Received: from hera.kernel.org ([209.128.68.125]:36813 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262367AbVGLE61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 00:58:27 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: zImage on 2.6?
Date: Tue, 12 Jul 2005 04:58:06 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <daviku$8g4$1@terminus.zytor.com>
References: <20050503012951.GA10459@animx.eu.org> <20050502193503.20e6ac6e.rddunlap@osdl.org> <20050503104503.GA11123@animx.eu.org> <m3k6mg5fly.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1121144286 8709 127.0.0.1 (12 Jul 2005 04:58:06 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 12 Jul 2005 04:58:06 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m3k6mg5fly.fsf@defiant.localdomain>
By author:    Krzysztof Halasa <khc@pm.waw.pl>
In newsgroup: linux.dev.kernel
>
> Wakko Warner <wakko@animx.eu.org> writes:
> 
> > x86.  Does zImage work on other arches?  (I've only ever dealt with alpha
> > and sparc other than x86)
> 
> Sure, ARM for example. 2 MB is not a problem.

That's a completely different meaning of zImage then.  The x86 boot
protocol (also used on x86-64) only allows 504K for zImage.

For x86, zImage is so dead it's not even funny.  I tried to remove it
a few years ago but people complained.

	-hpa
