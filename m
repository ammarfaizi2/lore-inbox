Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVESNsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVESNsy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 09:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVESNsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 09:48:54 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:50383 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262495AbVESNsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 09:48:53 -0400
Subject: Re: Illegal use of reserved word in system.h
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org, "Gilbert, John" <JGG@dolby.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Adrian Bunk <bunk@stusta.de>,
       Arjan van de Ven <arjan@infradead.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
	 <20050518195337.GX5112@stusta.de>
	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	 <20050519112840.GE5112@stusta.de>
	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
	 <1116505655.6027.45.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
	 <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 19 May 2005 09:47:52 -0400
Message-Id: <1116510472.15866.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 09:01 -0400, Richard B. Johnson wrote:

> 
> Would you please explain 'auxiliary' vector???

Looking in fs/binfmt_elf.c I see that information is passed in via elf
info.  But the PAGE_SIZE passed in is ELF_EXEC_PAGESIZE which may not
actually be the same as PAGE_SIZE.

-- Steve


