Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUJHTIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUJHTIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 15:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270085AbUJHSVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:21:06 -0400
Received: from web52306.mail.yahoo.com ([206.190.39.101]:3434 "HELO
	web52306.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269881AbUJHSN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:13:57 -0400
Message-ID: <20041008181354.75169.qmail@web52306.mail.yahoo.com>
Date: Fri, 8 Oct 2004 11:13:54 -0700 (PDT)
From: shankar krishnamurthy <kshan_77@yahoo.com>
Subject: character device interface to existing socket interface.
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <70640000.1097257199@w-hlinder.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking for help in writing character 
device interface for existing socket interface.

Planning to write as kernel module. Kernel 2.4.20. 
It will be a simple pass through to the socket. I mean
it sits above socket and whatever user gives, the 
driver passes it to socket and vice versa. In that
sense its pass-through or a psuedo driver.

When user creates the device, he gives already 
connected socket to device driver. Once device
gets created, user closes the socket!

My hunch is that this looks so common that somebody
would have already written or have some pointer to it.

Somebody may wonder why one needs this ...but for
we can take it as *application specific* requirement.

Please let me know if you know anything about it.


		
__________________________________
Do you Yahoo!?
Read only the mail you want - Yahoo! Mail SpamGuard.
http://promotions.yahoo.com/new_mail 
