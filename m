Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVAYBr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVAYBr0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVAYBr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 20:47:26 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:55193 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261629AbVAYBrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 20:47:24 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Date: Tue, 25 Jan 2005 02:46:56 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Linux 2.6.11-rc2: vmnet breaks; put skb_copy_datagram b
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, torvalds@osdl.org
X-mailer: Pegasus Mail v3.50
Message-ID: <75C33211637@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jan 05 at 1:41, Sytse Wielinga wrote:
> Linus, could you please put skb_copy_datagram back in place? It's not used
> anymore in the kernel, but the vmnet module (in vmware) still uses this
> interface to skb_copy_datagram_iovec.

There is no reason for doing this.  Just grab latest vmmon & vmnet
from http://platan.vc.cvut.cz/ftp/pub/vmware/vmware-any-any-update89.tar.gz,
and enjoy latest and greatest modules.  Besides this one you'll get lot
of other fixes and improvements for free ;-)
                                                Petr Vandrovec

