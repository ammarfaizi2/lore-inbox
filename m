Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266313AbUFPVlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266313AbUFPVlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266321AbUFPVlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:41:09 -0400
Received: from web60908.mail.yahoo.com ([216.155.196.84]:20106 "HELO
	web60908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266313AbUFPVlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:41:05 -0400
Message-ID: <20040616214104.34614.qmail@web60908.mail.yahoo.com>
Date: Wed, 16 Jun 2004 14:41:04 -0700 (PDT)
From: Brian Gao <bgaolinux@yahoo.com>
Subject: Does Kernel 2.6.6 support more than 32 groups?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need a Linux kernel to support more than 32 groups.
The 2.6.6 kernel source file include/linux/limits.h
contains the line:

define NGROUPS_MAX    65536  /* supplemental group   
IDs are available*/

I also changed 

#define NGROUPS_SMALL  32 

to 

#define NGROUPS_SMALL   256

in include/linux/sched.h file.
 
But when I compiled it on Redhat Enterprise Linux 3.0
(with glibc-2.3.2-95.20) it still gives 32 group
limitation. What else do I need to change? Do I need
to modify glibc? If so how?

I'd appreciate your help.

Brian 


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
