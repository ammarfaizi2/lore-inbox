Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbTEaO7D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 10:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTEaO7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 10:59:03 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:17114 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S264366AbTEaO66
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 10:58:58 -0400
Message-Id: <200305311512.h4VFCHhj010685@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Exception trace for i386, mark II
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Date: Sat, 31 May 2003 16:39:37 +0200
References: <20030531121008$2041@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> 
> This is a new implementation of exception trace for i386.
> 
> It adds a new exception-trace sysctl (default to off), which when enabled
> triggers printk for unhandled fault signals (SIGSEGV etc.). 

Isn't this very similar to the KERN_S390_USER_DEBUG_LOGGING sysctl?
Maybe the code can be merged, or at least they can use the same
numeric value for the sysctl.

        Arnd <><
