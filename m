Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266529AbUFWNop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266529AbUFWNop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 09:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266535AbUFWNoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 09:44:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:44976 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266501AbUFWNoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 09:44:34 -0400
Subject: Re: [PATCH] ppc32: Support for new Apple laptop models
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200406230710.15104.jbarnes@engr.sgi.com>
References: <1087934829.1832.3.camel@gaston>
	 <200406221745.31553.jbarnes@engr.sgi.com> <1087940927.1854.43.camel@gaston>
	 <200406230710.15104.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1087997834.1839.132.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 23 Jun 2004 08:37:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-23 at 06:10, Jesse Barnes wrote:
> On Tuesday, June 22, 2004 5:48 pm, Benjamin Herrenschmidt wrote:
> > Can you check out in more details the OS X driver ? I think there
> > need to be some i2s tweaking when changing the format and/or the
> > frequency. Doing that right would allow to support 8 & 16 bits
> > properly at least.
> 
> Sure, do you have an URL for that stuff?  I don't want to have to go through 
> any red tape to get access to the Darwin sources...

An AppleID account is enough, or there's opendarwin CVS but that may not
be completely up-to-date cs. apple latest versions.

> > Also, don't leave the commented out line, especially with  the c++
> > style comments. If the chip can byteswap, make sure you have proper
> > code to do this, if not, leave can_byteswap to 0, or people will
> > experience all sorts of funny troubles ;)
> 
> Sure.
> 
> Jesse
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

