Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272781AbTHKQlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272799AbTHKQlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:41:51 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:24731 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S272781AbTHKQke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:40:34 -0400
Date: Mon, 11 Aug 2003 09:40:12 -0700
From: Larry McVoy <lm@bitmover.com>
To: davej@redhat.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
Message-ID: <20030811164012.GB858@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>, davej@redhat.com,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.sourceforge.net
References: <E19mF4Y-0005Eg-00@tetrachloride>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19mF4Y-0005Eg-00@tetrachloride>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few comments on why I don't like this patch:
    1) It's a formatting only patch.  That screws over people who are using
       BK for debugging, now when I double click on these changes I'll get
       to your cleanup patch, not the patch that was the last substantive
       change.
    2) "if (expr) statement;" really ought to be considered legit coding style.
       It's a one line "shorty" and it lets you see more of the code on a 
       screen.
    
On the other hand, the author carried things too far when they did

	if (expr) statement;
	else	  statement;

that's too hard for your eyes to parse quickly IMO.
