Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269390AbTGJQ5I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269424AbTGJQ5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:57:07 -0400
Received: from tmi.comex.ru ([217.10.33.92]:2988 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S269417AbTGJQzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:55:02 -0400
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@osdl.org>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] minor optimization for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Thu, 10 Jul 2003 21:09:12 +0000
In-Reply-To: <20030710100102.32950703.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 10 Jul 2003 10:01:02 -0700")
Message-ID: <874r1ugkcn.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87smpeigio.fsf@gw.home.net>
	<20030710042016.1b12113b.akpm@osdl.org> <87isqaiegy.fsf@gw.home.net>
	<20030710085155.40c78883.akpm@osdl.org> <877k6qgldo.fsf@gw.home.net>
	<20030710100102.32950703.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 AM> Alex Tomas <bzzz@tmi.comex.ru> wrote:
 >> 
 >> OK. fixed version:

 AM> Looks nice.  Now, Andreas did mention a while back that the locking rework
 AM> added an additional complexity to this optimization.  Perhaps he can remind
 AM> us of the details there?

he meant than 2.5 don't use lock_sb() for inode allocation. this patch is safe
from this point of view.


