Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbUBXWki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbUBXWiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:38:09 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:65214 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S262513AbUBXWhl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:37:41 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Promise SATA driver
Date: Tue, 24 Feb 2004 22:37:40 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c1gjnj$68q$1@news.cistron.nl>
References: <200402241110.07526.andrew@walrond.org> <403B73E3.80100@pobox.com> <200402241630.36105.andrew@walrond.org> <403B8028.1060700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1077662260 6426 62.216.29.200 (24 Feb 2004 22:37:40 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <403B8028.1060700@pobox.com>,
Jeff Garzik  <jgarzik@pobox.com> wrote:
>Andrew Walrond wrote:
>> I take it the software raid thing wasn't part of the gpl'ed driver, and isn't 
>> something that is likely to happen?
>
>
>In 2.4, RAID0 and RAID1 are supported via the pdcraid driver.

I looked at those drivers, but they don't support error recovery
in RAID1 mode of any kind. It's just "read from one drive,
write to both" but if one disk goes south you're SOL.

Just FYI ;)

Mike.

