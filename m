Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWAYCTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWAYCTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 21:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWAYCTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 21:19:39 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:39175 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750769AbWAYCTj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 21:19:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n+aG4aRf/rX8zAKnpxFnnHpZQYv0UCIuNVXLfwNGNu4IVYXPQLibVla9XS+7BLm4mtNbkA7616RWnxkzSIs72fSa1JI68UfOfddb/daqLlQHDPVLqbW+VEgfIubs0+8DBYh3NuV3SmdoxsUvLu7PFQOsn+zE+AdD+xL3OKdVxVA=
Message-ID: <eb0e02f40601241819v78b33acbi44c49749c86d0e67@mail.gmail.com>
Date: Wed, 25 Jan 2006 13:19:38 +1100
From: Grant Coady <gcoady@gmail.com>
To: Ed Sweetman <safemode@comcast.net>
Subject: Re: poor raid0 performance in 2.6.16-rc1-mm2?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43D6B7F9.3020407@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43D6B7F9.3020407@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/06, Ed Sweetman <safemode@comcast.net> wrote:
> I'll have to reboot to double check that this is specific to the above
> kernel version, but It seems something is either wrong with my
> particular kernel config for raid0, or my raid0 is setup wrong.
>
> my raid0 uses 64k chunk sizes on an ext3 fs that's 367GB large, (across
> two identical sata disks on nforce4 chipset)
>
> I have partitions on both drives of equal size (2 altogether) that are
> outside of the raid0.  I dbenched those partitions, the raid0 device,
> and libata pata devices i also have (same rpm, less cache, same company).
>
> pata disk : 403MB/sec
> sata disk 1: 446MB/sec
> raid0 : between 336MB/sec and 386MB/sec

Hmm, looks optimistic, I performed some raid0, raid1 testing on SATA recently
here: http://bugsplatter.mine.nu/test/raid_times

Grant.
