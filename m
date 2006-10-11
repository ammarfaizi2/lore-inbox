Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWJKM7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWJKM7R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWJKM7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:59:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47573 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751248AbWJKM7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:59:16 -0400
Subject: Re: [PATCH] Add support for the generic backlight device to the
	IBM ACPI driver
From: Arjan van de Ven <arjan@infradead.org>
To: Richard Hughes <hughsient@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com
In-Reply-To: <1160571257.4936.7.camel@hughsie-laptop>
References: <20061009113235.GA4444@homac.suse.de>
	 <20061011113042.GA4725@ucw.cz>  <1160571257.4936.7.camel@hughsie-laptop>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 11 Oct 2006 14:59:13 +0200
Message-Id: <1160571553.3000.373.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 13:54 +0100, Richard Hughes wrote:
> On Wed, 2006-10-11 at 11:30 +0000, Pavel Machek wrote:
> > Looks okay to me. It would be nice to get this in, so that we teach
> > people to use generic interface, and so that we can remove crappy
> > interfaces in future...
> 
> What about needing a module parameter "enable-old-interface" so by
> default be only support the new interface but can support the legacy one
> if the user is running old userspace stuff? Insane?

not worth the code imo; you're adding code to save some old cruft ;)


