Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTCaXnd>; Mon, 31 Mar 2003 18:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261935AbTCaXnd>; Mon, 31 Mar 2003 18:43:33 -0500
Received: from holomorphy.com ([66.224.33.161]:26054 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261934AbTCaXna>;
	Mon, 31 Mar 2003 18:43:30 -0500
Date: Mon, 31 Mar 2003 15:54:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Joel.Becker@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030331235431.GU30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Badari Pulavarty <pbadari@us.ibm.com>, Joel.Becker@oracle.com,
	linux-kernel@vger.kernel.org
References: <200303311541.50200.pbadari@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303311541.50200.pbadari@us.ibm.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 03:41:50PM -0800, Badari Pulavarty wrote:
> 2) sysfs inode use up 50 MB of low memory
>         - 4000 disks without partitions create (4000 * 35) = 140,000 inodes in 
> /sysfs.  So, it uses 50 MB of lowmem. 
> 3) dcache is eating up 25 MB of low memory.

These are actually the same thing (the inode pinning references are
actually held by the dentries IIRC). shaggy and I are brewing up
something to show to gregkh and mochel in the near future.


-- wli
