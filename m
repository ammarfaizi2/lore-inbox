Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTAJQEu>; Fri, 10 Jan 2003 11:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTAJQEu>; Fri, 10 Jan 2003 11:04:50 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:26217 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S265339AbTAJQEs>;
	Fri, 10 Jan 2003 11:04:48 -0500
Date: Fri, 10 Jan 2003 17:13:31 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Ludovic Drolez <ludovic.drolez@freealter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BLKBSZSET still not working on 2.4.18 ?
Message-ID: <20030110161331.GA19942@win.tue.nl>
References: <3E1EE7A3.1050401@freealter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1EE7A3.1050401@freealter.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 04:32:51PM +0100, Ludovic Drolez wrote:

> I'm trying to backup a partition on an IDE drive which has an odd number 
> of sectors (204939). With a stock open/read you cannot access the last 
> sector
> 
> What can I do ? Wait for a patch in 2.5.xxx ?

Hmm - I recall fixing this both for 2.4 and 2.5.

If that patch is not part of current 2.4, then probably this should be
regarded as a known deficiency of 2.4. If I were to maintain a stable
2.4 I would not accept such changes.

You can test 2.5. If it is wrong there I must submit a patch.

Andries
