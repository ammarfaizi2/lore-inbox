Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269094AbUHXWwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269094AbUHXWwl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 18:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269095AbUHXWwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 18:52:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:482 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269094AbUHXWwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 18:52:37 -0400
Date: Tue, 24 Aug 2004 15:47:53 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org, mdharm-usb@one-eyed-alien.net,
       marcelo.tosatti@cyclades.com
Subject: Re: PANIC [2.4.27] usb-storage
Message-Id: <20040824154753.503d0fc9@lembas.zaitcev.lan>
In-Reply-To: <4127AF46.6090908@ttnet.net.tr>
References: <4127AF46.6090908@ttnet.net.tr>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004 23:23:34 +0300
"O.Sezer" <sezeroz@ttnet.net.tr> wrote:

> Unable to handle kernel paging request at virtual address e0ce6d90

> >>EIP; e0ce6d90 <[usb-storage]usb_stor_CBI_irq+0/70>   <=====

Something unmapped a page where the module code resided. Are you sure
you haven't tried to run rmmod? Bad idea.

-- Pete
