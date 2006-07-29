Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWG2RCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWG2RCu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 13:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWG2RCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 13:02:50 -0400
Received: from mx1.suse.de ([195.135.220.2]:38597 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751252AbWG2RCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 13:02:49 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] i386: Do backtrace fallback too
Date: Sat, 29 Jul 2006 19:03:10 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200607290300.k6T306Fc003168@hera.kernel.org> <200607291835.54379.ak@suse.de> <20060729164238.GB16946@redhat.com>
In-Reply-To: <20060729164238.GB16946@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607291903.10969.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > > 	print_symbol("DWARF2 unwinder stuck at %s\n",
>  > > 		UNW_PC(info.regs));
>  > >
>  > > be using %p ?
>  >
>  > Yes good catch.
>
> The x86-64 equivalent also has an instance of the same bug.

Actually on double checking the %s is correct because it's print_symbol

-Andi
