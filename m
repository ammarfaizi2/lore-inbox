Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbUKJMhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbUKJMhf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 07:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbUKJMhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 07:37:35 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:9139 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261714AbUKJMh3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 07:37:29 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm4
Date: Wed, 10 Nov 2004 13:36:12 +0100
User-Agent: KMail/1.6.2
Cc: Fabio Coatti <cova@ferrara.linux.it>, Andrew Morton <akpm@osdl.org>
References: <20041109074909.3f287966.akpm@osdl.org> <200411101240.37882.cova@ferrara.linux.it>
In-Reply-To: <200411101240.37882.cova@ferrara.linux.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411101336.12077.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 of November 2004 12:40, Fabio Coatti wrote:
> Alle 16:49, martedì 9 novembre 2004, Andrew Morton ha scritto:
> 
> > - A process matter: I'm now tracking any regressions since 2.6.9, with the
> >   intention that we not release 2.6.10 until they're all fixed.  (Where
> >   "tracking" means shoving them into a folder called "bugs").  So if 
anyone
> > is aware of any post-2.6.9 regressions, please make sure that I have a 
copy
> > of the email.
> 
> usb storage has some problems; IIRC 2.6.9 is OK, the problem is only in mm 
> series; I can test other versions but it will take some time :)
> Maybe it's a minor bug, but it can freeze usb subsystem...
> 
> Short description: inserting usb storage device causes problems and device 
is 
> not created; this happens with or without ub driver.
> I've already reported this, but not for mm4, maybe something is different,

Confirmed for -mm4 on AMD64 (two different configurations).  Plain -rc1 works 
fine on both.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
