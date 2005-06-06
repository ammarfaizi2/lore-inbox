Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVFFLq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVFFLq3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 07:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVFFLq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 07:46:29 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:7066 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261308AbVFFLqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 07:46:13 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Date: Mon, 6 Jun 2005 07:46:22 -0400
User-Agent: KMail/1.8
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <200506051015.33723.kernel-stuff@comcast.net> <20050606092925.GA23831@wotan.suse.de>
In-Reply-To: <20050606092925.GA23831@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506060746.23047.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 June 2005 05:29, Andi Kleen wrote:
> And does it work with nopmtimer ?
>
> -Andi

Thanks for trimming the CC list. 

No it doesn't work with nopmtimer - music still plays fast. I have to go back 
to 2.6.11 to get it to play at right speed. 

Relevant lines from rc5 with nopmtimer -

Jun  6 07:11:59 tux-gentoo [    0.000000] time.c: Using 1.193182 MHz PIT 
timer.
Jun  6 07:11:59 tux-gentoo [    0.000000] time.c: Detected 797.952 MHz 
processor.
Jun  6 07:11:59 tux-gentoo [   22.152032] time.c: Using PIT/TSC based 
timekeeping.


Parag
