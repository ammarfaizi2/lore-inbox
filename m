Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263128AbVCEQaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbVCEQaE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbVCEQ0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:26:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40204 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262008AbVCEQS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:18:29 -0500
Date: Sat, 5 Mar 2005 16:18:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: diff command line?
Message-ID: <20050305161822.H3282@flint.arm.linux.org.uk>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200503051048.00682.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200503051048.00682.gene.heskett@verizon.net>; from gene.heskett@verizon.net on Sat, Mar 05, 2005 at 10:48:00AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 10:48:00AM -0500, Gene Heskett wrote:
> What are the options normally used to generate a diff for public 
> consumption on this list?  

diff -urpN orig new

where "orig" and "new" both contain the top level "linux" directory,
so the resulting patch can be applied with patch -p1.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
