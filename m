Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWAISdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWAISdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWAISdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:33:12 -0500
Received: from ns.suse.de ([195.135.220.2]:17334 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030236AbWAISdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:33:11 -0500
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] Access Control Lists for tmpfs
References: <20060108230116.073177000@blunzn.suse.de>
	<20060108231235.440671000@blunzn.suse.de>
From: Andi Kleen <ak@suse.de>
Date: 09 Jan 2006 19:33:08 +0100
In-Reply-To: <20060108231235.440671000@blunzn.suse.de>
Message-ID: <p73zmm5w8t7.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> writes:


> +config TMPFS_POSIX_ACL

I always hated all these different ACL CONFIG options for different
file systems. ACL is not different from many other features
which don't have own options in every subsystem.

How about just making a single global ACL CONFIG and all the file
systems just turn on ACL implicitely if that one is set?

-Andi
