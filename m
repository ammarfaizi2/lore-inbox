Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVCGR7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVCGR7E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 12:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVCGR7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 12:59:04 -0500
Received: from orb.pobox.com ([207.8.226.5]:63167 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261197AbVCGR7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 12:59:00 -0500
Date: Mon, 7 Mar 2005 09:58:54 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Stefan Seyfried <seife@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Bug 4298] swsusp fails to suspend if CONFIG_DEBUG_PAGEALLOC is   also enabled
Message-ID: <20050307175854.GC5083@ip68-4-98-123.oc.oc.cox.net>
References: <20050306030852.23eb59db.akpm@osdl.org> <20050306225730.GA1414@elf.ucw.cz> <20050306195954.6d13cff9.akpm@osdl.org> <422C0A6B.1060700@suse.de> <20050307092206.GB5083@ip68-4-98-123.oc.oc.cox.net> <20050307093512.GE8311@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307093512.GE8311@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 10:35:12AM +0100, Pavel Machek wrote:
> > Regarding Pavel's patch, it seems to me that it might be better to print
> > the message at boot time, instead of (or in addition to?) his patch.
> > Maybe we should be disabling swsusp altogether at boot in that case, if
> > that's not unreasonably hard to implement.
> 
> Hmm, yes, that would certainly be better. It would need new
> per-architecture hook... Feel free to implement it.

It looks like it's going to be more difficult than I was hoping for.

I would recommend accepting Pavel's patch. It's a definite improvement
over the existing code, and it could be a long while until I have a
boot-time message patch that is both functional and clean enough to be
incorporated into mainline.

-Barry K. Nathan <barryn@pobox.com>

