Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVAHKeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVAHKeA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 05:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVAHKdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 05:33:46 -0500
Received: from web41404.mail.yahoo.com ([66.218.93.70]:18107 "HELO
	web41404.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261879AbVAHJR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 04:17:29 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=w8AeFUsUmFxYyip8utHXAqS8k2huIWW6v7uPuYI6hmfNBtZvojXLcu94KRb6VWcIy27v/SrPaQZPrDsdCybKUr4u7UPQO5qNRlmRFSv3K5X8cKtsime9Ez6xnpvzFLYZYMuL+6uduGPtaqp1x/d895tVvwO9V2QZLfVfISPZVFQ=  ;
Message-ID: <20050108091728.315.qmail@web41404.mail.yahoo.com>
Date: Sat, 8 Jan 2005 01:17:28 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: kmalloc usage question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
     I read kmalloc kernel-api.pdf page and found that


 * %GFP_USER - Allocate memory on behalf of user.  May
sleep.
 *
 * %GFP_KERNEL - Allocate normal kernel ram.  May
sleep.
 *
 * %GFP_ATOMIC - Allocation will not sleep.  Use
inside interrupt handlers.
What i want to know if i write a Device driver that
has kmalloc statements require allocate some string
variable then which flag i should use?
As apis said GFP_USER. But if i want my kernel module
to be require to work in kernel always then can it be
ok to use GFP_KERNEL??
What are then disadvantages to that???
regards,
cranium




		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 

