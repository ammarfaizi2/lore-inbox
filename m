Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161435AbWASVXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161435AbWASVXX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWASVXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:23:23 -0500
Received: from gate.in-addr.de ([212.8.193.158]:55721 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1161432AbWASVXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:23:22 -0500
Date: Thu, 19 Jan 2006 22:22:18 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, Neil Brown <neilb@suse.de>
Cc: "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060119212218.GK22163@marowsky-bree.de>
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com> <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr> <17358.52476.290687.858954@cse.unsw.edu.au> <Pine.LNX.4.61.0601192104560.26558@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0601192104560.26558@yvahk01.tjqt.qr>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-01-19T21:12:02, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> > Use md for raid1, raid5, raid6 - anything with redundancy.
> > Use dm for multipath, crypto, linear, LVM, snapshot
> There are pairs of files that look like they would do the same thing:
> 
>   raid1.c  <-> dm-raid1.c
>   linear.c <-> dm-linear.c

Sure there's some historical overlap. It'd make sense if DM used the md
raid personalities, yes.


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

