Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVBHUHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVBHUHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVBHUHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:07:09 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:36725 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261651AbVBHUHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:07:00 -0500
Date: Tue, 8 Feb 2005 21:07:03 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Martin Hicks <mort@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ACPI_BOOT for ia64 (2.6.11-rc3-mm1)
Message-ID: <20050208200703.GC8505@mars.ravnborg.org>
Mail-Followup-To: Martin Hicks <mort@wildopensource.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050208200338.GF11310@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208200338.GF11310@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 03:03:38PM -0500, Martin Hicks wrote:
> 
> Hi Andrew,
> 
> One of your patches in 2.6.11-rc3-mm1 breaks ACPI_BOOT for ia64.  It
> removes the dependence on CONFIG_ACPI and makes it exclusively depend on
> X86_HT, which is wrong.

Thanks for the patch.
Already fixed in my kconfig tree that Andrew pulls.

	Sam
