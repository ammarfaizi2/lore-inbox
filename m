Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbTKJSfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbTKJSfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:35:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30355 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264044AbTKJSfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:35:36 -0500
Message-ID: <3FAFDA5E.4050905@pobox.com>
Date: Mon, 10 Nov 2003 13:35:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Oliver M. Bolzer" <oliver@gol.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Success with  Promise FastTrak S150 TX4 (Re: [BK PATCHES] libata
 fixes)
References: <20031108172621.GA8041@gtf.org> <20031110095248.GA20497@magi.fakeroot.net> <3FAFBC28.5000600@pobox.com> <20031110172613.GA2962@magi.fakeroot.net>
In-Reply-To: <20031110172613.GA2962@magi.fakeroot.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver M. Bolzer wrote:

> I disabled /dev/mdX Software-RAID5 on two of the boxes that have the
> hardware (got 8 of them) and did some preliminary benchmarking using
> bonnie++ 1.02b. The hardware is P4-2.4GHz, 1GB RAM (highmem-enabled) wich
> 4 Maxtor SATA-drives with 200GBs each. The partitions I ran the tests
> on are 186GB large.
[...]

> The performance differences are not that big that they would really
> matter. One is better at one direction while the other is better at the
> other direction.

Well, I'll still be looking to increase performance in libata, even such ;)

But stability before performance :)


> I am REALLY happy that a free-as-in-freedom driver exist for the hardware
> that has a much more certain future thant a
> looks-like-GPL-on-the-first-look-but-one--.o-has-no-source driver. And
> the libata code was really nice to read and follow, even though I knew
> almost nothing about disk driver. THANK YOU!

Thank Promise, too.  They are actively supporting my efforts on this 
driver with hardware and docs.  Promise has also provided Arjan (author 
of "pdcraid") with documentation on their vendor-specific RAID format, 
and they are making other efforts to better support open source, and be 
more friendly with the open source community.

	Jeff



