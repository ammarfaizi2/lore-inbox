Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWFLRTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWFLRTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWFLRTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:19:55 -0400
Received: from hera.kernel.org ([140.211.167.34]:7826 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751188AbWFLRTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:19:53 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: TCSBRK(1) on pl2303 USB/serial returns prematurely
Date: Mon, 12 Jun 2006 10:19:29 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6k7n1$h4c$1@terminus.zytor.com>
References: <20060612145750.GA19338@kestrel.barix.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1150132769 17549 127.0.0.1 (12 Jun 2006 17:19:29 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 12 Jun 2006 17:19:29 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060612145750.GA19338@kestrel.barix.local>
By author:    Karel Kulhavy <clock@twibright.com>
In newsgroup: linux.dev.kernel
>
> Hello
> 
> TCSBRK(1) ioctl system call on pl2303 USB/serial converter on 2.6.16.19
> returns prematurely. Additional 53ms delay is necessary to work this
> around at speed of 57600. TCSBRK(1) is translation of the tcdrain()
> function by glibc. With ordinary serial port the TCSBRK(1) seems to work
> correctly.
> 

Not only that, but pl2303 doesn't seem to be able to receive a break
properly, either.

	-hpa
