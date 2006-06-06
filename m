Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWFFVL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWFFVL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWFFVL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:11:29 -0400
Received: from khc.piap.pl ([195.187.100.11]:10756 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751117AbWFFVL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:11:29 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: paulkf@microgate.com, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
	<20060605184407.230bcf73.rdunlap@xenotime.net>
	<1149622813.11929.3.camel@amdx2.microgate.com>
	<m3u06yc9mr.fsf@defiant.localdomain>
	<20060606134816.363cbeca.rdunlap@xenotime.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 06 Jun 2006 23:11:27 +0200
In-Reply-To: <20060606134816.363cbeca.rdunlap@xenotime.net> (Randy Dunlap's message of "Tue, 6 Jun 2006 13:48:16 -0700")
Message-ID: <m3hd2yc7ls.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> I think that the main problem is that SYNCLINK wants to be able
> to use some functions from hdlc_generic.c when
> CONFIG_HDLC=m.  How do you handle that?

I don't :-)

If CONFIG_HDLC=m then all hw drivers below can only be modules.
-- 
Krzysztof Halasa
