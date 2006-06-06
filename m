Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWFFWwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWFFWwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWFFWwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:52:50 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:34434
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751248AbWFFWwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:52:50 -0400
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
From: Paul Fulghum <paulkf@microgate.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
In-Reply-To: <m3zmgpc3ba.fsf@defiant.localdomain>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	 <20060605230248.GE3963@redhat.com>
	 <20060605184407.230bcf73.rdunlap@xenotime.net>
	 <1149622813.11929.3.camel@amdx2.microgate.com>
	 <m3u06yc9mr.fsf@defiant.localdomain>
	 <20060606134816.363cbeca.rdunlap@xenotime.net>
	 <20060606140822.c6f4ef37.rdunlap@xenotime.net>
	 <m3zmgpc3ba.fsf@defiant.localdomain>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 17:52:33 -0500
Message-Id: <1149634353.2633.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 00:44 +0200, Krzysztof Halasa wrote:

> BTW: selecting CONFIG_HDLC without selecting at least one protocol
> does nothing good (except that the thing actually builds). As I said,
> I'd rather let the user decide what it's needed.

Agreed, but this is not about sensible kernel configuration.
The synclink drivers have been building and working with generic
HDLC for some time with no problem.

What we are cleaning up here is errors from building
randomly (and not necessarily usable) generated configs.

The only thing I'm unsure of at this point is the
changes to net/wan/Makefile. I'm setting up some
test builds to check this out.

--
Paul

