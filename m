Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTIBDFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 23:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263477AbTIBDFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 23:05:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:7350 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263475AbTIBDFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 23:05:14 -0400
Date: Mon, 1 Sep 2003 20:05:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Panagiotis Papadakos <papadako@csd.uoc.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IOMEGA ZIP 100 ATAPI problems with 2.6
Message-Id: <20030901200530.64ad6fb9.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.53.0309020539380.9075@oneiro.csd.uch.gr>
References: <Pine.GSO.4.53.0308310037230.27956@oneiro.csd.uch.gr>
	<3F515301.4040305@sbcglobal.net>
	<3F532C67.6070904@sbcglobal.net>
	<Pine.GSO.4.53.0309020539380.9075@oneiro.csd.uch.gr>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Papadakos <papadako@csd.uoc.gr> wrote:
>
> I tried to see if the problem had to do anything with acpi or Preemptible
>  kernel. So I disabled both of them but the problem still exists. At least
>  I got a better Oops, which I had to write down on paper. So it probably
>  has many errors. Here it is if it helps anyone...

You seem to have rampant memory corruption all over the place.

Do you have CONFIG_DEBUG_KERNEL, CONFIG_DEBUG_SLAB and
CONFIG_DEBUG_PAGEALLOC set?  If not, please enable them and retry.

