Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUCAVPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 16:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUCAVPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 16:15:10 -0500
Received: from ns.suse.de ([195.135.220.2]:16621 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261436AbUCAVPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 16:15:08 -0500
Date: Mon, 1 Mar 2004 22:14:58 +0100
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Cc: akpm@osdl.org, yi.zhu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [start_kernel] Suggest to move parse_args() before trap_init()
Message-Id: <20040301221458.50b0dade.ak@suse.de>
In-Reply-To: <20040301205426.GA5862@redhat.com>
References: <Pine.LNX.4.44.0403011721220.2367-100000@mazda.sh.intel.com>
	<20040301025637.338f41cf.akpm@osdl.org>
	<p73vfloz45t.fsf@verdi.suse.de>
	<20040301205426.GA5862@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004 20:54:26 +0000
Dave Jones <davej@redhat.com> wrote:


> Did that get fixed in 2.6 ?

It's called directly after paging_init now. That should be early enough.

-Andi
