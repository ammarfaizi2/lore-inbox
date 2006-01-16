Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWAPGt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWAPGt4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 01:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWAPGt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 01:49:56 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:52125 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750753AbWAPGtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 01:49:55 -0500
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] pktcdvd & udf bugfixes
References: <43C5D71B.1060002@cfl.rr.com> <m3oe2e2983.fsf@telia.com>
	<43C94464.4040500@cfl.rr.com> <m3hd861o2r.fsf@telia.com>
	<43C982C0.1070605@cfl.rr.com> <m3r779z9on.fsf@telia.com>
	<m31wz9yuoh.fsf@telia.com> <43CB0C81.1030605@cfl.rr.com>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Jan 2006 07:49:51 +0100
In-Reply-To: <43CB0C81.1030605@cfl.rr.com>
Message-ID: <m3oe2cy8ds.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> writes:

> I get this:
> 
> drivers/block/pktcdvd.c:1992: error: label ‘out_unclaim’ used but
> not defined
> 
> Also the patch did not cleanly apply. It looks like you didn't get all
> of your changes into the diff. Unless you have some other patches that
> I don't? This is against 2.6.15 right?

I thought it would apply on top of your patch, but didn't actually
check. Try this patch series instead:

        http://web.telia.com/~u89404340/patches/packet/2.6/2.6.15-git11/

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
