Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265724AbSJTBcS>; Sat, 19 Oct 2002 21:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265728AbSJTBcS>; Sat, 19 Oct 2002 21:32:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39180 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265724AbSJTBcS>;
	Sat, 19 Oct 2002 21:32:18 -0400
Date: Sun, 20 Oct 2002 02:38:21 +0100
From: Matthew Wilcox <willy@debian.org>
To: Marcus Alanen <maalanen@ra.abo.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] setup_arg_pages. ARCH_STACK_GROWSUP ??
Message-ID: <20021020023821.B5285@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As far as I can see, setup_arg_pages code is hosed for the
> ARCH_STACK_GROWSUP case, completely wrong types... Does any arch even
> use this?

Yes, but kunmap is a NOP on that architecture, so nobody noticed.  Patch
looks good though.

-- 
Revolutions do not require corporate support.
