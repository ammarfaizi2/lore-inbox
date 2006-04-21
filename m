Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWDUCnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWDUCnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWDUCnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:43:07 -0400
Received: from gherkin.frus.com ([192.158.254.49]:53001 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S1750895AbWDUCnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:43:05 -0400
Subject: Re: strncpy (maybe others) broken on Alpha
In-Reply-To: <20060420215723.GA3949@bigip.bigip.mine.nu> "from Mathieu Chouquet-Stringer
 at Apr 20, 2006 11:57:23 pm"
To: Mathieu Chouquet-Stringer <mchouque@free.fr>
Date: Thu, 20 Apr 2006 21:43:04 -0500 (CDT)
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060421024304.2D851DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Chouquet-Stringer wrote:
> On Fri, Apr 21, 2006 at 01:24:17AM +0400, Ivan Kokshaysky wrote:
> > Broken binutils, maybe?
> 
> Stop the press, it's definitely a binutils issue. 2.16.1 doesn't trigger
> the error.

Still not out of the woods here :-(.  Built 2.6.17-rc2 with gcc-4.0
and binutils 2.16.91 (package name is binutils_2.16.1cvs20060117-1)
and I'm still getting the kobject_add error.

Mathieu -- you mentioned testing with a cross-compile.  Was that the
case for your reported success?  How about a native compile?  I'm
pretty sure this *is* a binutils issue, but we don't quite have it
nailed down yet.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
