Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBMSE4>; Tue, 13 Feb 2001 13:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129237AbRBMSEq>; Tue, 13 Feb 2001 13:04:46 -0500
Received: from moe.rice.edu ([128.42.5.4]:34276 "EHLO moe.rice.edu")
	by vger.kernel.org with ESMTP id <S129032AbRBMSE3>;
	Tue, 13 Feb 2001 13:04:29 -0500
Date: Tue, 13 Feb 2001 12:04:18 -0600
From: Rahul Jain <rahul@rice.edu>
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [?] __alloc_pages: 1-order allocation failed.
Message-ID: <20010213120418.A2468@photino.sid.rice.edu>
Reply-To: Rahul Jain <rahul@rice.edu>
In-Reply-To: <20010213105957.A16713@main.braxis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010213105957.A16713@main.braxis.co.uk>; from kszysiu@braxis.co.uk on Tue, Feb 13, 2001 at 10:59:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2001 at 10:59:57AM +0100, Krzysztof Rusocki wrote:
> 
> Hi,
> 
> Here's what i've found today in logs:
> 
> Feb 13 02:10:41 main kernel: __alloc_pages: 1-order allocation failed. 
> Feb 13 02:10:42 main last message repeated 143 times
> Feb 13 02:10:47 main kernel: ed. 
> Feb 13 02:10:47 main kernel: __alloc_pages: 1-order allocation failed. 
> Feb 13 02:50:30 main syslogd 1.3-3: restart (remote reception).
> 

I typically get thousands of such messages when using my SCSI CDRW (I think
it's specifically when I'm cat'ing or dd'ing from the drive. Specifically, I
get 2- and 3-order allocation failures. I'll use the patch Andi Kleen posted to
track down the exact locations of these errors. There seem to be no ill effects
at all from these errors.

-- 
-> -/-                       - Rahul Jain -                       -\- <-
-> -\- http://linux.rice.edu/~rahul -=- mailto:rahul-jain@usa.net -/- <-
-> -/- "I never could get the hang of Thursdays." - HHGTTG by DNA -\- <-
|--|--------|--------------|----|-------------|------|---------|-----|-|
   Version 11.423.999.220020101.23.50110101.042
   (c)1996-2000, All rights reserved. Disclaimer available upon request.
