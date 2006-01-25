Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWAYNKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWAYNKA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 08:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWAYNKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 08:10:00 -0500
Received: from quechua.inka.de ([193.197.184.2]:8588 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751143AbWAYNKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 08:10:00 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: io performance...
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <9cfek33vwvo.fsf@nist.gov>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1F1kPO-0001dz-00@calista.inka.de>
Date: Wed, 25 Jan 2006 14:09:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Soboroff <isoboroff@acm.org> wrote:
> simulation) and database accesses.  These are random accesses, which
> is the worst access pattern for RAID.  Seek time in a RAID equals the
> longest of all the drives in the RAID, rather than the average.

Well, actually it equals to the shortest seek time and it distributes the
seeks to multiple spindles (at least for raid1).

Gruss
Bernd
