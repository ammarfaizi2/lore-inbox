Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268148AbUHWVln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268148AbUHWVln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268147AbUHWVjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:39:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:18333 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268118AbUHWVgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:36:06 -0400
Date: Mon, 23 Aug 2004 14:34:31 -0700
From: Greg KH <greg@kroah.com>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.8.1 - 2004-08-22.21.30) - 3 New warnings (gcc 3.2.2)
Message-ID: <20040823213431.GA4371@kroah.com>
References: <200408231251.i7NCpJDK006874@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408231251.i7NCpJDK006874@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 05:51:19AM -0700, John Cherry wrote:
> drivers/cpufreq/cpufreq_userspace.c:157:2: warning: #warning The /proc/sys/cpu/ and sysctl interface to cpufreq will be removed from the 2.6. kernel series soon after 2005-01-01
> drivers/cpufreq/proc_intf.c:15:2: warning: #warning This module will be removed from the 2.6. kernel series soon after 2005-01-01

Um, these look like valid warnings to me, you might want to review these
by hand before sending them out.

thanks,

greg k-h
