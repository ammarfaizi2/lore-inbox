Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbTDVOJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbTDVOJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:09:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:34989 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262992AbTDVOJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:09:33 -0400
Date: Tue, 22 Apr 2003 07:20:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: boot messages
Message-Id: <20030422072023.5fa430b6.rddunlap@osdl.org>
In-Reply-To: <20030422130135.GA16465@gtf.org>
References: <UTC200304221245.h3MCjp122735.aeb@smtp.cwi.nl>
	<20030422130135.GA16465@gtf.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003 09:01:36 -0400 Jeff Garzik <jgarzik@pobox.com> wrote:

| > A separate discussion:
| > Ethernet cards are numbered differently by different kernels.
| > A bit annoying, and I have tried to fix this a few times,
| > but probably one just should accept it.
| > The previous time this came up people answered and said:
| > use "nameif".
| 
| Two points here:
| 
| 1) official answer is, "if you want stable ethernet interface naming,
| use nameif"

I did a short writeup about this.  See
  http://www.xenotime.net/linux/doc/network-interface-names.txt

| 2) I have been told more than once that ethernet device allocation order
| changed between 2.4 and 2.5.  I consider this a bug, and welcome patches
| to fix it.  Note, though, that the recent PCI probe order fixes that
| went in via Andrew Morton may have addressed this issue for some people.

Patch has already been posted 2 times.

--
~Randy
