Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWC1H5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWC1H5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 02:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWC1H5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 02:57:05 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:33674 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751359AbWC1H5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 02:57:04 -0500
Date: Tue, 28 Mar 2006 09:55:21 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Random GCC segfaults -- Was: [2.6.16] slab error in
 slab_destroy_objs(): cache `radix_tree_node'...
Message-ID: <20060328095521.52ea3424@localhost>
In-Reply-To: <20060326215346.1b303010@localhost>
References: <20060326215346.1b303010@localhost>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006 21:53:46 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> PS: I've got another "gcc segfault" trying to build Qt again after a
> reboot but I don't think this is a memory problem (actually I have
> a memory problem (single bit error) but it should be cured with
> memmap=1K$214014K ;).

I've got others NON reproducible gcc segfaults, usually compiling some
huge CPP source.

Now I'm back to 2.6.15.6 and I'm stress testing GCC, no segfaults so
far.

Doing a git-bisect is maybe possible... but it will take ages since I
don't have a test case :(!

Additionally there's the slab error (seen just one time)...


If anyone have some idea like try-to-revert-this-patch let me know.

-- 
	Paolo Ornati
	Linux 2.6.15.6 on x86_64
