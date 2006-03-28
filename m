Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWC1WvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWC1WvS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWC1WvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:51:18 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34203 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964773AbWC1WvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:51:15 -0500
Subject: Re: BUG in Linux 2.6.16/2.6.16.1 (compilation failure of third
	party software)
From: Lee Revell <rlrevell@joe-job.com>
To: Thierry Godefroy <thgodef@nerim.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060328202905.18cb2cb0.thgodef@nerim.net>
References: <20060328202905.18cb2cb0.thgodef@nerim.net>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 17:51:11 -0500
Message-Id: <1143586271.11792.118.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 20:29 +0200, Thierry Godefroy wrote:
> Paragon_NTFS_3.x.v5.1 fails to compile (with gcc v3.4.3) with the following
> errors:

It's not a bug when an upgrade causes third party kernel modules not to
compile - your code needs to be updated to work with 2.6.16.

Linux makes no effort to guarantee source or binary compatibility with
out of tree kernel modules, or userspace code that includes kernel
headers.

Lee

