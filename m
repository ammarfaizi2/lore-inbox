Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVIKStm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVIKStm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVIKStm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:49:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6891
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965030AbVIKStl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:49:41 -0400
Date: Sun, 11 Sep 2005 11:49:43 -0700 (PDT)
Message-Id: <20050911.114943.73157389.davem@davemloft.net>
To: maillist@jg555.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43245C56.5000905@jg555.com>
References: <43228E4E.4050103@jg555.com>
	<20050910.010114.28468998.davem@davemloft.net>
	<43245C56.5000905@jg555.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Gifford <maillist@jg555.com>
Date: Sun, 11 Sep 2005 09:33:26 -0700

> For the Sparc64 builds, I'm starting to look at using OBP to do the booting.

OBP cannot boot because it doesn't understand the ext2
filesystem, and therefore cannot get at the image.

The only thing you can do is netboot kernel images converted
to a.out format using the elf2aout tool.

Stop fighting city hall and work on fixing SILO to support
a 64-bit build if you want, instead of all of these hacks.
:-)
