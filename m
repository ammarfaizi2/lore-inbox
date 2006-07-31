Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWGaUI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWGaUI1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWGaUI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:08:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:21963 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932449AbWGaUI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:08:26 -0400
From: Andi Kleen <ak@suse.de>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] x86_64 built-in command line
Date: Mon, 31 Jul 2006 22:07:58 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <20060731171442.GI6908@waste.org>
In-Reply-To: <20060731171442.GI6908@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607312207.58999.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
> +#ifdef CONFIG_CMDLINE_BOOL
> +	strlcpy(saved_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +#endif

I think I would prefer a strcat.

Also you should describe the exact behaviour (override/append) in Kconfig help.

-Andi
