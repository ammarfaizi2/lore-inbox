Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTDUFWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 01:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbTDUFWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 01:22:23 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:46515 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263769AbTDUFWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 01:22:22 -0400
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] archs: vmlinux.lds.S unification
References: <Pine.LNX.4.44.0304180925320.9070-100000@chaos.physics.uiowa.edu>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 21 Apr 2003 14:34:17 +0900
In-Reply-To: <Pine.LNX.4.44.0304180925320.9070-100000@chaos.physics.uiowa.edu>
Message-ID: <buod6jgct2e.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai-germaschewski@uiowa.edu> writes:
> I'm wondering if anybody (particularly arch maintainers) have comments or
> objections for changes like the appended, which separate out common bits
> from arch/$ARCH/vmlinux.lds.S and put them into

Well the definition of EXTABLE is wrong on the v850, for the same reason
the definition of RODATA is wrong; see the previous discusion on lkml
for details.

[The v850 has hairier linker script(s) than most args, and making it
conform to the model you've chosen will probably require all its linker
scripting to be rewritten.  I haven't gotten around to figuring out how
that can be done yet.]

-Miles
-- 
Somebody has to do something, and it's just incredibly pathetic that it
has to be us.  -- Jerry Garcia
