Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbUDPVtG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbUDPVqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:46:07 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:32772 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263848AbUDPVoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:44:22 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use Kconfig.debug (v3-proposed) (was: Re: [PATCH] use Kconfig.debug (v2))
Date: Fri, 16 Apr 2004 23:38:14 +0200
User-Agent: KMail/1.6.1
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm@osdl.org
References: <20040415220338.3e351293.rddunlap@osdl.org> <200404161042.21164@WOLK> <20040416110149.3e353333.rddunlap@osdl.org>
In-Reply-To: <20040416110149.3e353333.rddunlap@osdl.org>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404162338.14345@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 April 2004 20:01, Randy.Dunlap wrote:

Hi Randy,

> Then let's move KALLSYMS to the very end of the menu.
> At the very least it should be after the last "depends on
> DEBUG_KERNEL" entry, but it still interferes with that
> dependency chain as either of us has it.

ok.


> Maybe do the same for parisc and s390, so that they don't show up
> at all?

dooh. Seems I forgot it :( - Sorry.


> sparc is the same way:  only entry(s) depend on DEBUG_KERNEL.
> Same for x86_64.

yes.


> However, I did it that way for "future-proofing".  Makes it
> easy for someone to add an entry without having to think about
> higher-level parameters/values etc.

good point, but for now it may confuse people. Once someone's gonna put 
selectable stuff in there we can change that back at once :)


ciao, Marc

