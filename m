Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWDTVkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWDTVkv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWDTVkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:40:51 -0400
Received: from gherkin.frus.com ([192.158.254.49]:46605 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S1751338AbWDTVku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:40:50 -0400
Subject: Re: strncpy (maybe others) broken on Alpha
In-Reply-To: <20060421012417.B16574@jurassic.park.msu.ru> "from Ivan Kokshaysky
 at Apr 21, 2006 01:24:17 am"
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Date: Thu, 20 Apr 2006 16:40:48 -0500 (CDT)
CC: Mathieu Chouquet-Stringer <mchouque@free.fr>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060420214049.0575EDBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> On Thu, Apr 20, 2006 at 10:55:55PM +0200, Mathieu Chouquet-Stringer wrote:
> > Same code compiled with 2.95.3 fails too (I'll be trying 4.1.0 just for
> > the kick of it, if it cross-compiles ok but I don't expect it to work
> > either).
> 
> Broken binutils, maybe?

Possible...  On my Debian system, the installed binutils package *was*
binutils_2.15-6.  I just upgraded to binutils_2.16.1cvs20060117-1 with
the related gcc and cpp packages for default 4.0 compilation, and we'll
see if that makes any difference.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
