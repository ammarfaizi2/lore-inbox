Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318487AbSIBVpw>; Mon, 2 Sep 2002 17:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSIBVpv>; Mon, 2 Sep 2002 17:45:51 -0400
Received: from mail.zmailer.org ([62.240.94.4]:23456 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S318487AbSIBVpv>;
	Mon, 2 Sep 2002 17:45:51 -0400
Date: Tue, 3 Sep 2002 00:50:19 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Stupid anti-spam testings...
Message-ID: <20020902215019.GB5834@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a many of vger's recipients are doing return-path verification
testing for SMTP's MAIL FROM address.

I would not mind that, EXCEPT that those bloody stupid things don't
have any sane caches at all!    VGER is sending 300+ messages per
day to 3500+ recipients of linux-kernel list EVERY DAY, and every
outgoing message is now getting oodles of those probes!

Folks,  when you deploy that kind of testers, DO VERIFY THAT THEY
HAVE SANE CACHES!  A positive result shall be cached for at least
two hours, a negative result shall be cached for at least 30 minutes.

That would send a dozen back-probes towards vger from recipient
system, instead of present 300+ !


/Matti Aarnio -- who considers some cures worse than the original problem...
