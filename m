Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265213AbUFWLLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUFWLLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 07:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUFWLLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 07:11:20 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:35516 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265213AbUFWLLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 07:11:19 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc32: Support for new Apple laptop models
Date: Wed, 23 Jun 2004 07:10:15 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1087934829.1832.3.camel@gaston> <200406221745.31553.jbarnes@engr.sgi.com> <1087940927.1854.43.camel@gaston>
In-Reply-To: <1087940927.1854.43.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406230710.15104.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 22, 2004 5:48 pm, Benjamin Herrenschmidt wrote:
> Can you check out in more details the OS X driver ? I think there
> need to be some i2s tweaking when changing the format and/or the
> frequency. Doing that right would allow to support 8 & 16 bits
> properly at least.

Sure, do you have an URL for that stuff?  I don't want to have to go through 
any red tape to get access to the Darwin sources...

> Also, don't leave the commented out line, especially with  the c++
> style comments. If the chip can byteswap, make sure you have proper
> code to do this, if not, leave can_byteswap to 0, or people will
> experience all sorts of funny troubles ;)

Sure.

Jesse
