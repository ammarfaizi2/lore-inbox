Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbUJ0Cwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUJ0Cwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbUJ0Cwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:52:50 -0400
Received: from gold.pobox.com ([208.210.124.73]:53726 "EHLO gold.pobox.com")
	by vger.kernel.org with ESMTP id S261600AbUJ0Cwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:52:35 -0400
Date: Tue, 26 Oct 2004 19:52:22 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>, jbaron@redhat.com,
       alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: Linux 2.4.28-rc1
Message-ID: <20041027025222.GB9375@ip68-4-98-123.oc.oc.cox.net>
References: <417E5904.9030107@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417E5904.9030107@ttnet.net.tr>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 05:02:44PM +0300, O.Sezer wrote:
> There are many lost/forgotten patches posted here on lkml. Since 2.4.28
> is near and 2.4 is going into "deep maintainance" mode soon, I gathered
> a short list of some of them.  There, sure, are many more of them,  but
> here it goes.
> I think they deserve a re-review and re-consideration for inclusion.
[snip]

Here's another one:
Jason Baron: 2.4.28-pre3 tty/ldisc fixes
http://marc.theaimsgroup.com/?l=linux-kernel&m=109604869516678&w=2

AFAICT the above patch is the fix for:
CAN-2004-0814: Linux terminal layer races
http://marc.theaimsgroup.com/?l=bugtraq&m=109837405025108&w=2

This patch seems to be working fine for me, but I don't know if anyone
else has really tested it at all, nor do I know (one way or the other)
if the security issues are serious enough to apply this for 2.4.28-rc
and not 2.4.29-pre. Also, I'm running on a single-processor system with
no HyperThreading, so if there are any SMP-related issues then I have no
way of experiencing them.

Anyway, since it's a security fix (unless I'm mistaken), I guess it's
worth considering for inclusion...

-Barry K. Nathan <barryn@pobox.com>

