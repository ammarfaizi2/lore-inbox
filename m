Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUBINWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUBINWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:22:23 -0500
Received: from relaycz.systinet.com ([62.168.12.68]:4806 "HELO
	relaycz.systinet.com") by vger.kernel.org with SMTP id S265144AbUBINWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:22:22 -0500
Subject: Re: [matroxfb] Second head is on but fb1 not accessible
From: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <32263100CF@vcnet.vc.cvut.cz>
References: <32263100CF@vcnet.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1076332904.8119.20.camel@narsil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 09 Feb 2004 14:21:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Make sure that /dev/fb1 is character device 29,1 and not 29,32. 2.2.x kernels
> accept 29,32 only, 2.4.x accept both, and 2.6.x accept 29,1 only.

Thanks for super-fast reply :-), I did think it could be related to
minor device number.

But anyway, shouldn't I have at least console visible on the second head
(even if /dev/fb1 is not accessible)? I tested it by attaching my
monitor to second head and nothing appeared.

Jan "Pogo" Mynarik

-- 
Jan Mynarik <mynarikj@phoenix.inf.upol.cz>

