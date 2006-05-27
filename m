Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWE0WrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWE0WrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 18:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWE0WrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 18:47:10 -0400
Received: from mx1.suse.de ([195.135.220.2]:64406 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964971AbWE0WrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 18:47:08 -0400
From: Neil Brown <neilb@suse.de>
To: Arend Freije <afreije@inn.nl>
Date: Sun, 28 May 2006 08:46:56 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17528.55008.287088.705263@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID-1 and Reiser4 issue: umount hangs
In-Reply-To: message from Arend Freije on Sunday May 28
References: <4478CF33.80609@inn.nl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday May 28, afreije@inn.nl wrote:
> 
> My questions:
> - how can I find the cause of the hanging umount?

# echo t > /proc/sysrq-trigger

and look at the resulting kernel messages, particularly for the
unmount process.  If they don't make sense to you, post them.

> - how can I fix it?

Understand the problems, change the code :-)
Probably we can manage it together...

NeilBrown
