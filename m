Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310295AbSDEBLk>; Thu, 4 Apr 2002 20:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310441AbSDEBLa>; Thu, 4 Apr 2002 20:11:30 -0500
Received: from willow.seitz.com ([207.106.55.140]:3090 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id <S310295AbSDEBLQ>;
	Thu, 4 Apr 2002 20:11:16 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Thu, 4 Apr 2002 20:11:13 -0500
To: joeja@mindspring.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020405011113.GA1990@willow.seitz.com>
In-Reply-To: <Springmail.0994.1017964447.0.72656900@webmail.atl.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on a AMD 1200Mhz/512Meg ram, which seemed odd.

Is your motherboard one with a Promise Ultra100 controller integrated?

If so, you can shave that time off by recomiling your kernel with
"Special UDMA Feature" and then disabling the Ultra100 bios.  You should
still be able to get UDMA without loading the annoying BIOS.

Ross Vandegrift
ross@willow.seitz.com
