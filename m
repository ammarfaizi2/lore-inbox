Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUD2BiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUD2BiB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUD2Bhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:37:45 -0400
Received: from ozlabs.org ([203.10.76.45]:44991 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262931AbUD2BfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:35:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16528.23304.760917.196324@cargo.ozlabs.ibm.com>
Date: Thu, 29 Apr 2004 11:31:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <16528.23219.17557.608276@cargo.ozlabs.ibm.com>
References: <409021D3.4060305@fastclick.com>
	<20040428170106.122fd94e.akpm@osdl.org>
	<409047E6.5000505@pobox.com>
	<40905127.3000001@fastclick.com>
	<20040428180038.73a38683.akpm@osdl.org>
	<16528.23219.17557.608276@cargo.ozlabs.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> What I have noticed with 2.6.6-rc1 on my dual G5 is that if I rsync a
> gigabyte or so of data over to another machine, it then takes several
> seconds to change focus from one window to another.  I can see it
> slowly redraw the window title bars.  It looks like the window manager
> is getting swapped/paged out.

I meant to add that this is with swappiness = 60.

Paul.
