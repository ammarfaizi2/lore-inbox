Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWBDXzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWBDXzy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWBDXzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:55:53 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14249
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932590AbWBDXzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:55:52 -0500
Date: Sat, 04 Feb 2006 15:55:54 -0800 (PST)
Message-Id: <20060204.155554.55536246.davem@davemloft.net>
To: sparclinux@vger.kernel.org
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Niagara work in progress GIT tree
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At the following tree:

	master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.17.git

you will find the current Niagara "work in progress" kernel changes
I've been doing.  A lot of it is infrastructure and not directly
related to Niagara per-se, but the hypervisor API and TLB flushing
plus Niagara optimized memcpy is in there.

Andrew, feel free to pull this into -mm as regressions on existing
pre-Niagara systems need to be weeded out as fast as possible.

Folks, if you hit some problem, please test against vanilla 2.6.x GIT
to make sure it really is a new issue and not an already existing one.
I'm interested in the report either way, but it's vitally important to
know if the problem got introduced by the sparc-2.6.17 tree or not.

Thanks.
