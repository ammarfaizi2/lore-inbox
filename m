Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUBINND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUBINND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:13:03 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:49349 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S265141AbUBINM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:12:59 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
Date: Mon, 9 Feb 2004 14:12:21 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [matroxfb] Second head is on but fb1 not accessible
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <32263100CF@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Feb 04 at 14:09, Jan Mynarik wrote:

> I'm using matroxfb from (2.6.2 and 2.6.0 patch from
> http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest/ tested too) on
> G400 (32MB dual head). Other details are SMP, preempt kernel, Debian
> unstable.
> 
> Cannot open /dev/fb1: No such device

Make sure that /dev/fb1 is character device 29,1 and not 29,32. 2.2.x kernels
accept 29,32 only, 2.4.x accept both, and 2.6.x accept 29,1 only.
                                                Petr Vandrovec
                                                

