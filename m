Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWDGQm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWDGQm2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 12:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWDGQm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 12:42:28 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:48833 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932437AbWDGQm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 12:42:28 -0400
Date: Fri, 7 Apr 2006 11:43:09 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem building UML kernel with 2.6.16.1 -- dies when linking vmlinux
Message-ID: <20060407154309.GA4911@ccure.user-mode-linux.org>
References: <443580A4.1020806@nortel.com> <20060406215131.GA6422@ccure.user-mode-linux.org> <4435A0DA.1030606@nortel.com> <20060406234145.GA6893@ccure.user-mode-linux.org> <443676ED.10907@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443676ED.10907@nortel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 08:27:57AM -0600, Christopher Friesen wrote:
> I just used CONFIG_MODE_TT based on the config comments for 
> CONFIG_PT_PROXY: "If you want to do kernel debugging, say Y here; 
> otherwise say N.".  This then required MODE_TT.

Yeah, that's out of date, and I'm in the process of fixing stuff like that.

> Can I run UML under gdb in skas mode?

"gdb linux" and away you go.

				Jeff
