Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269102AbUJTTpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269102AbUJTTpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270488AbUJTTkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:40:22 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:468 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S270479AbUJTTht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:37:49 -0400
Date: Wed, 20 Oct 2004 21:37:41 +0200
From: Tim Cambrant <cambrant@acc.umu.se>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: power/disk.c: small fixups
Message-ID: <20041020193741.GA27096@shaka.acc.umu.se>
References: <20041020181617.GA29435@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020181617.GA29435@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-Operating-System: SunOS shaka.acc.umu.se 5.8 Generic_117000-05 sun4u sparc SUNW,Ultra-250 Solaris
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 08:16:17PM +0200, Pavel Machek wrote:
> power_down may never ever fail, so it does not really need to return
> anything. Kill obsolete code and fixup old comments. Please apply,
> 

...

> @@ -162,7 +163,7 @@
>   *
>   *	If we're going through the firmware, then get it over with quickly.
>   *
> - *	If not, then call pmdis to do it's thing, then figure out how
> + *	If not, then call swsusp to do it's thing, then figure out how
>   *	to power down the system.
>   */

I hate to be picky, but changing "it's" to the more correct "its" would
perhaps be nice to do when you're at it?

-- 

Tim Cambrant <cambrant@acc.umu.se>
http://www.acc.umu.se/~cambrant/
