Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266752AbTGKUqU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266771AbTGKUqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:46:19 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:40406 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S266752AbTGKUqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:46:17 -0400
Date: Fri, 11 Jul 2003 13:55:32 -0700
From: Larry McVoy <lm@bitmover.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Strange BK behaviour?
Message-ID: <20030711205532.GB17804@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307111715400.5537@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307111715400.5537@freak.distro.conectiva>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, it's there, bkbits just isn't showing it because it is an empty merge
changeset.  That's a bug.  If you care, file a bug on bk/web with a 
summary like "show merge changesets if they are tagged".
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
