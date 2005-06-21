Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVFUNTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVFUNTo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVFUNSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:18:23 -0400
Received: from ns.firmix.at ([62.141.48.66]:39296 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S261439AbVFUNPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:15:53 -0400
Subject: Re: [PATCH] Pointer cast warnings in scripts/
From: Bernd Petrovitsch <bernd@firmix.at>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Roman Zippel <zippel@linux-m68k.org>, kbuild-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42B80F40.8000609@drzeus.cx>
References: <42B7F740.6000807@drzeus.cx>
	 <Pine.LNX.4.61.0506211413570.3728@scrub.home> <42B80AF9.2060708@drzeus.cx>
	 <Pine.LNX.4.61.0506211451040.3728@scrub.home>  <42B80F40.8000609@drzeus.cx>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 21 Jun 2005 15:14:13 +0200
Message-Id: <1119359653.18845.55.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 14:59 +0200, Pierre Ossman wrote:
[...]
> It should only be a matter of reversing the patches for Solaris then.
> But that will of course bring back the warnings on that platform. I'd
> say we should stick with what the standard says. Unfortunatly I don't

The C-standard about "char", "signed char" and "unsigned char"?
These are 3 different types.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

