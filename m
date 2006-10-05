Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWJETvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWJETvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWJETvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:51:51 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:46251 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751045AbWJETvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:51:50 -0400
To: balagi@justmail.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "akpm@osdl.org" <akpm@osdl.org>
Subject: Re: [PATCH 3/11] 2.6.18-mm3 pktcdvd: new pkt_find_dev()
References: <op.tguo6ngciudtyh@master>
From: Peter Osterlund <petero2@telia.com>
Date: 05 Oct 2006 21:51:41 +0200
In-Reply-To: <op.tguo6ngciudtyh@master>
Message-ID: <m3fye2mtgy.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Maier" <balagi@justmail.de> writes:

> Also pkt_remove_dev() can use now the device id of the mapped
> block device to remove the mapping.

Why would that be desirable? I think it's better to implement this
feature in the user space tools and leave the kernel interface
simple.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
