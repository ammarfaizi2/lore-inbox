Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269211AbTGJLTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269212AbTGJLTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:19:03 -0400
Received: from tmi.comex.ru ([217.10.33.92]:57767 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S269211AbTGJLTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:19:01 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] minor optimization for EXT3
From: bzzz@tmi.comex.ru
Date: Thu, 10 Jul 2003 15:33:17 +0000
In-Reply-To: <20030710042016.1b12113b.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 10 Jul 2003 04:20:16 -0700")
Message-ID: <87isqaiegy.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87smpeigio.fsf@gw.home.net>
	<20030710042016.1b12113b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 AM> Alex Tomas <bzzz@tmi.comex.ru> wrote:
 >> 
 >> Andreas Dilger proposed do not read inode's block during inode updating
 >> if we have enough data to fill that block. here is the patch.

 AM> ok, thanks.  Could you please redo it for the current kernel?

hmmm. it was against 2.5.72. I just tried it on 2.5.74 and all is OK.


