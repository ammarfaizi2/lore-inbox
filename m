Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTJOUGa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 16:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTJOUGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 16:06:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:54698 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264256AbTJOUG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 16:06:29 -0400
Subject: Re: IA32 (2.6.0-test7 - 2003-10-09.18.30) - 1 New warnings (gcc
	3.2.2)
From: John Cherry <cherry@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1066247805.5145.1.camel@cherrytest.pdx.osdl.net>
References: <200310100645.h9A6joFZ008847@cherrypit.pdx.osdl.net>
	 <Pine.LNX.4.53.0310101249380.15705@montezuma.fsmlabs.com>
	 <1066247805.5145.1.camel@cherrytest.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1066248385.5145.11.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 Oct 2003 13:06:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did I mention that this comment preceded the commented out code?

/* fixme: enable this again, if the dvb-c w/ analog module work properly

The change went in on 10/09 as part of patchset 1.1329 (hunold).

John

On Wed, 2003-10-15 at 12:56, John Cherry wrote:
> This is not bogus.  In linus' bk tree, line 374 is commented out!
> 
> /*
>         vbi_workaround(dev);
> */
> 
> John
> 
> On Fri, 2003-10-10 at 09:50, Zwane Mwaikambo wrote:
> > On Thu, 9 Oct 2003, John Cherry wrote:
> > 
> > > drivers/media/common/saa7146_vbi.c:6: warning: `vbi_workaround' defined but not used
> > 
> > That appears bogus, it's used in vbi_open on line 374
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

