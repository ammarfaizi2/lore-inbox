Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278642AbRKFISH>; Tue, 6 Nov 2001 03:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278643AbRKFIR6>; Tue, 6 Nov 2001 03:17:58 -0500
Received: from web12208.mail.yahoo.com ([216.136.173.92]:59398 "HELO
	web12208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278642AbRKFIRp>; Tue, 6 Nov 2001 03:17:45 -0500
Message-ID: <20011106081744.40294.qmail@web12208.mail.yahoo.com>
Date: Tue, 6 Nov 2001 00:17:44 -0800 (PST)
From: Amit Kulkarni <amitncsu@yahoo.com>
Subject: Insmod gives unsresolved symbol
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

I am trying to write a device driver which calls
certain functions/variables from the kernel 
(e.g. ipv4_explicit_null from
/usr/src/linux/net/mpls/mpls_init.c )

But when I try to insert the module using insmod it
gives me an error saying unresolved symbol
ipv4_explicit_null

thinking the kernel did not export the said symbol  I
added EXPORT_SYMBOL(ipv4_explicit_null) in the file
mpls_init.c 
Now I can see the symbol in System.map
but my problem still persists. 

Am I exporting symbols properly or is there anything
else that needs to be done .

please advise 
thanks in anticipation,
amit

__________________________________________________
Do You Yahoo!?
Find a job, post your resume.
http://careers.yahoo.com
