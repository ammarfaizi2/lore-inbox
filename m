Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWARIOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWARIOJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWARIOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:14:08 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:168 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S964772AbWARIOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:14:07 -0500
Date: Wed, 18 Jan 2006 09:14:07 +0100
From: Sander <sander@humilis.net>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Ross Vandegrift <ross@jose.lug.udel.edu>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060118081407.GC18945@localhost.localdomain>
Reply-To: sander@humilis.net
References: <20060117174531.27739.patches@notabene> <43CCA80B.4020603@tls.msk.ru> <20060117095019.GA27262@localhost.localdomain> <43CCD453.9070900@tls.msk.ru> <20060117160829.GA16606@lug.udel.edu> <43CD3388.9050107@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CD3388.9050107@tls.msk.ru>
X-Uptime: 07:10:58 up 61 days, 21:15, 12 users,  load average: 3.17, 2.39, 2.01
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote (ao):
> Most problematic case so far, which I described numerous times (like,
> "why linux raid isn't Raid really, why it can be worse than plain
> disk") is when, after single sector read failure, md kicks the whole
> disk off the array, and when you start resync (after replacing the
> "bad" drive or just remapping that bad sector or even doing nothing,
> as it will be remapped in almost all cases during write, on real
> drives anyway),

If the (harddisk internal) remap succeeded, the OS doesn't see the bad
sector at all I believe.

If you (the OS) do see a bad sector, the disk couldn't remap, and goes
downhill from there, right?

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
