Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319792AbSIMVNz>; Fri, 13 Sep 2002 17:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319791AbSIMVNz>; Fri, 13 Sep 2002 17:13:55 -0400
Received: from holomorphy.com ([66.224.33.161]:1749 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319792AbSIMVNx>;
	Fri, 13 Sep 2002 17:13:53 -0400
Date: Fri, 13 Sep 2002 14:12:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-user@lists.sourceforge.net,
       Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>
Subject: Re: [reiserfs-dev] Re: UML 2.5.34
Message-ID: <20020913211252.GC3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nikita Danilov <Nikita@Namesys.COM>, Jeff Dike <jdike@karaya.com>,
	linux-kernel@vger.kernel.org,
	user-mode-linux-user@lists.sourceforge.net,
	Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>
References: <15745.48975.172938.121684@laputa.namesys.com> <200209131429.JAA02083@ccure.karaya.com> <15745.59564.28543.921212@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <15745.59564.28543.921212@laputa.namesys.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike writes:
[not sure what, got trimmed/mangled somewhere]

On Fri, Sep 13, 2002 at 05:31:24PM +0400, Nikita Danilov wrote:
> pte_addr_t and CLOCK_TICK_RATE were undefined.
> Wrong macro in include/asm-um/percpu.h resulted in
> include/asm-um/cacheflush.h never being included and a macros from the
> latter undefined also.
> By the way, I am talking about Linus BK tree, rather than patches you
> have posted. Sorry for not mentioning this from the beginning.

This isn't Jeff's fault. pte_addr_t is from pte-highmem bits I did
merged after he did his mergework.


Cheers,
Bill
