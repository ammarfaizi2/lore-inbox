Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290815AbSBLHwr>; Tue, 12 Feb 2002 02:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290818AbSBLHwg>; Tue, 12 Feb 2002 02:52:36 -0500
Received: from holomorphy.com ([216.36.33.161]:22177 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S290815AbSBLHwW>;
	Tue, 12 Feb 2002 02:52:22 -0500
Date: Mon, 11 Feb 2002 23:52:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anish Srivastava <anish@bidorbuyindia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File BlockSize
Message-ID: <20020212075203.GF767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anish Srivastava <anish@bidorbuyindia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <002e01c1b397$1a26d270$3c00a8c0@baazee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <002e01c1b397$1a26d270$3c00a8c0@baazee.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 01:00:07PM +0530, Anish Srivastava wrote:
> Hi!!
> Is there any way I can have 8K block sizes in ext2, reiserfs or ext3.
> I am trying to install Oracle on Linux with 8K DB_Block_size.
> But it gives me a Block size mismatch saying that the File BlockSize is only
> 4K
> Maybe, there is a kernel patch available which enables Linux to create 8K
> file blocks.
> Thanks in anticipation....

Unfortunately filesystem block sizes larger than PAGE_SIZE are unsupported.
I wish they were, though.

Cheers,
Bill
