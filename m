Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267089AbUBFAY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267090AbUBFAY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:24:29 -0500
Received: from post.tau.ac.il ([132.66.16.11]:33246 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S267089AbUBFAXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:23:53 -0500
Date: Fri, 6 Feb 2004 02:23:47 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: reiserfs - difference between a commit and a transaction
Message-ID: <20040206002346.GA2571@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.3; VDF: 6.23.0.58; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to do some work on reiserfs to make it laptop-mode
compliant. After looking at the code because it was still noisy after I
thought I told correctly to be quite, raised a question that I was
hoping someone can clarify for me.

Reiserfs has both a transaction and a commit and I was wondering what
is which.

(I am mostly interested in this from the point of what max_trans_age
and max_commit_age affect)

Thanks
