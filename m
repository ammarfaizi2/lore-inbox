Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267828AbUHUUw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267828AbUHUUw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267814AbUHUUw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:52:56 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:52647 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267837AbUHUUrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:47:20 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P6 -- False positive?!
References: <cg7vju$pok$1@sea.gmane.org>
From: Karl Vogel <karl.vogel@seagha.com>
Date: Sat, 21 Aug 2004 22:47:46 +0200
In-Reply-To: <cg7vju$pok$1@sea.gmane.org> (Karl Vogel's message of "Sat, 21
 Aug 2004 19:09:56 +0200")
Message-ID: <m3isbc2p71.fsf@seagha.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this may have been my own mistake. In between all the kernel
compiles, I seem to have managed to do the following:

# CONFIG_X86_PM_TIMER is not set

Which was probably the cause. (was getting other side effects too, 
like keys stuck in repeat, 1-2 second freezes etc etc)
