Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbUE1MYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUE1MYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUE1MTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:19:38 -0400
Received: from zero.aec.at ([193.170.194.10]:23046 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262768AbUE1MTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 08:19:08 -0400
To: Andrey Panin <pazke@donpac.ru>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] 2.6.7-rc1-mm1, Simplify DMI matching data
References: <20Oc4-HT-25@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 28 May 2004 14:18:52 +0200
In-Reply-To: <20Oc4-HT-25@gated-at.bofh.it> (Andrey Panin's message of "Fri,
 28 May 2004 14:00:20 +0200")
Message-ID: <m3zn7su4lv.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin <pazke@donpac.ru> writes:

> simplify DMI blacklist table by removing the need to fill
> unused slots with NO_MATCH macro.

Can you please delay that patch for 2.7?
2.6 is for bug fixes, not for cleanups.

There are large third party patchkits for DMI and "cleaning up" 
the format will just cause lots of rejects and pain. A stable kernel
is supposed to be somewhat stable in internal interfaces too.

Thanks,

-Andi

