Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268118AbUINDHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268118AbUINDHk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 23:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269144AbUINDFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 23:05:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32433 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269139AbUINDEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 23:04:31 -0400
Date: Mon, 13 Sep 2004 23:04:24 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: "David S. Miller" <davem@davemloft.net>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: 2.6.9-rc1-mm5: TCP oopses
In-Reply-To: <20040913190858.12544431.davem@davemloft.net>
Message-ID: <Xine.LNX.4.44.0409132303160.22907-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, David S. Miller wrote:

> I think I fixed this one yesterday.  Callers of tcp_fragment()
> in tcp_output.c were not accounting packets correctly.  I
> believe this is what will fix it, and this is in Linus's
> tree already.

This patch is also in -mm5 (linus.patch), and the oopses go away when I 
back it out.

> I guess you have an e1000 in this box? :)

Yes.


- James
-- 
James Morris
<jmorris@redhat.com>


