Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWCPCHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWCPCHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 21:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWCPCHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 21:07:44 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:9434 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1750725AbWCPCHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 21:07:44 -0500
Date: Wed, 15 Mar 2006 23:38:11 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Philippe De Muyter <phdm@macqel.be>
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: PATCH m68knommu clear frame-pointer in start_thread
Message-ID: <20060315233810.GA4605@linux-mips.org>
References: <200603151647.k2FGl7Y04736@mail.macqel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603151647.k2FGl7Y04736@mail.macqel.be>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 05:47:07PM +0100, Philippe De Muyter wrote:

> When trying to print the calltrace of a user process on m68knommu targets
> gdb follows the frame-pointer en falls on unreachable adresses, because
> the frame pointer is not properly initialised by start_thread. This patch
> initialises the frame pointer to NULL in start_thread.
> 
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>

You've posted an ed-style diff.  Quite a safe method to make sure nobody
will read it.  Pleae repost a unified diff.

  Ralf
