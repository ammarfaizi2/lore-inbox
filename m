Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTJRQOD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 12:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTJRQOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 12:14:03 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:43270 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S261686AbTJRQOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 12:14:01 -0400
To: linux-kernel@vger.kernel.org
Path: 127.0.0.1!nobody
From: Peter Matthias <espi@epost.de>
Newsgroups: linux.kernel
Subject: Re: ACM USB modem on Kernel 2.6.0-test
Date: Sat, 18 Oct 2003 18:21:46 +0200
Organization: Tiscali Germany
Message-ID: <qaprmb.8a.ln@127.0.0.1>
References: <FwYB.Z9.25@gated-at.bofh.it> <HJ5m.2Eb.23@gated-at.bofh.it>
NNTP-Posting-Host: p62.246.116.166.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1066493472 65423 62.246.116.166 (18 Oct 2003 16:11:12 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Sat, 18 Oct 2003 16:11:12 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell schrieb:

> David Brownell wrote:
>> 
>> Hmm ... maybe usbcore would be better off with a less
>> naive algorithm for choosing defaults.  Like, preferring
>> configurations without proprietary device protocols.
>> That'd solve every cdc-acm case, and likely others.
> 
> In fact, here's a patch with that very change.  Does
> it make current 2.6.0-test kernels work "out of the box"
> again with your USB modems?

Yes, it works with ELSA Microlink USB. Thanks.

Peter
