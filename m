Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTJJU2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 16:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTJJU2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 16:28:22 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:63883 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262993AbTJJU2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 16:28:18 -0400
Date: Fri, 10 Oct 2003 21:28:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.4] EDD 4-byte MBR disk signature for the boot disk
Message-ID: <20031010202815.GB31006@mail.shareable.org>
References: <20031010145137.GC28795@mail.shareable.org> <Pine.LNX.4.44.0310101139270.12160-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310101139270.12160-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> it isn't important exactly what value is used, as long as only 
> the boot disk has it, and your code knows what to look for.

How can you be sure what's on other disks the code doesn't know about
at the time it writes to the boot disk?

You could just say the EDD thing is only to be used in very simple
configurations, but that's not half as useful as it could be - very
simple configurations don't need EDD anyway.

If we encourage its use, so that it's basically assumed to work and
boot processes use it by default, then people will be upset if things
like adding another disk to a system just to read data off it cause
the boot process to get confused.

-- Jamie
