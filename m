Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbUK0Xgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUK0Xgm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 18:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbUK0Xgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 18:36:42 -0500
Received: from canuck.infradead.org ([205.233.218.70]:57863 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261364AbUK0Xgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 18:36:40 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Matthew Wilcox <matthew@wil.cx>,
       Tonnerre <tonnerre@thundrix.ch>, dhowells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <41A90D66.4020204@osdl.org>
References: <19865.1101395592@redhat.com> <41A8AF8F.8060005@osdl.org>
	 <1101575782.21273.5347.camel@baythorne.infradead.org>
	 <200411272353.54056.arnd@arndb.de>  <41A90D66.4020204@osdl.org>
Content-Type: text/plain
Date: Sat, 27 Nov 2004 23:32:28 +0000
Message-Id: <1101598348.5278.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-27 at 15:27 -0800, Randy.Dunlap wrote:
> That's addressing a different problem.  I agree with
> David W. that we need to clean the kernel headers up.
> Let libc or libxyz provide the missing functionality.
> The borken programs were stealing something that wasn't
> promised to them AFAIK.

Not only wasn't it promised; it wasn't even working on some
architectures anyway.

-- 
dwmw2

