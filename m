Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWFFVbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWFFVbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWFFVbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:31:09 -0400
Received: from khc.piap.pl ([195.187.100.11]:6404 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751132AbWFFVbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:31:08 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: paulkf@microgate.com, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
	<20060605184407.230bcf73.rdunlap@xenotime.net>
	<1149622813.11929.3.camel@amdx2.microgate.com>
	<m3u06yc9mr.fsf@defiant.localdomain> <4485E723.4070201@microgate.com>
	<m3lksac7op.fsf@defiant.localdomain>
	<20060606142022.b184d1c5.rdunlap@xenotime.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 06 Jun 2006 23:31:05 +0200
In-Reply-To: <20060606142022.b184d1c5.rdunlap@xenotime.net> (Randy Dunlap's message of "Tue, 6 Jun 2006 14:20:22 -0700")
Message-ID: <m34pyyc6p2.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> So SYNCLINK has different capabilities depending on whether
> HDLC=m or HDLC=y ??

Only if SYNCLINK=y. Then if HDLC=m then it's unavailable.

When both are 'm' things should work. I'll check.
-- 
Krzysztof Halasa
