Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbUCNHK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 02:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbUCNHK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 02:10:57 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:24234 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S263311AbUCNHK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 02:10:56 -0500
Date: Sat, 13 Mar 2004 23:10:55 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: John Belmonte <john@neggie.net>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       arjanv@redhat.com
Subject: Re: [PATCH] (2.6.x) toshiba_acpi needs copy_from_user (fixes oops)
Message-ID: <20040314071055.GA2888@ip68-4-255-84.oc.oc.cox.net>
References: <20040314052510.GA2587@ip68-4-255-84.oc.oc.cox.net> <4053F304.5040903@neggie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4053F304.5040903@neggie.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 12:52:04AM -0500, John Belmonte wrote:
> Thank you for tracking this down.

That reminds me of something I forgot to mention in my original message.

I filed this in Red Hat Bugzilla (#117682), and Arjan van de Ven
mentioned the likely cause. I then confirmed it and coded up my patch.

So, Arjan deserves credit too. I meant to mention this in my original
e-mail, but I accidentally forgot. Sorry about that.

> Please don't apply this patch to the kernel tree.  I will submit a 
> variation via Len Brown.  In any case, it appears at least one other 
> ACPI driver has a similar bug, so best to go through Len.

Ok, sounds good to me.

-Barry K. Nathan <barryn@pobox.com>
