Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVADFTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVADFTA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVADFTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 00:19:00 -0500
Received: from orb.pobox.com ([207.8.226.5]:8166 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262092AbVADFSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 00:18:48 -0500
Date: Mon, 3 Jan 2005 21:18:39 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Pavel Machek <pavel@ucw.cz>, lindqvist@netstar.se, edi@gmx.de,
       john@hjsoft.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH] swsusp: properly suspend and resume *all* devices
Message-ID: <20050104051839.GB4465@ip68-4-98-123.oc.oc.cox.net>
References: <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103084713.GB2099@elf.ucw.cz> <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net> <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net> <20050103170807.GA8163@elf.ucw.cz> <20050103183317.GA1353@elf.ucw.cz> <20050104051529.GA4465@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104051529.GA4465@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 09:15:30PM -0800, Barry K. Nathan wrote:
> Hmmm... I'm not sure how necessary it is, and I think it slows down
> resume a tiny bit. However, the more I think about it the more correct it
> seems, so here's the follow-up patch. (Andrew, even if this patch is
> rejected, please commit my first one to the next -mm release. That patch
> alone is still an improvement over the current code.)

Ugh. I forgot to mention in my previous mail that the patch is against
2.6.10-mm1 + my previous patch (perhaps that was obvious), and that I've
lightly tested the patch (that probably wasn't obvious, to say the
least).

-Barry K. Nathan <barryn@pobox.com>

