Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUC0Sl3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 13:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUC0Sl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 13:41:29 -0500
Received: from web60502.mail.yahoo.com ([216.109.116.123]:32937 "HELO
	web60502.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261852AbUC0Sl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 13:41:27 -0500
Message-ID: <20040327184125.60430.qmail@web60502.mail.yahoo.com>
Date: Sat, 27 Mar 2004 10:41:25 -0800 (PST)
From: Carl Spalletta <ioanamitu@yahoo.com>
Subject: Re: locking pages into a processes` working set
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been trying to lock pages down so I can get
> a stable bench-mark without a bunch of paging.
> I have tried mlock(), mlockall(), etc., but both
> the RSS and SIZE entries shown by `top` vary all
> over the place when the process is active.

  Did you check the return value from mlock?
  Did you check the kernel source to make sure no cases have been
left out of the manpage?
  Have you taken account of the "imbedded" arch you're using?
  Have you checked the source for top and verified that the numbers
really mean what you suppose?
  Have you considered using some other tool for measurement or rolling
your own?






__________________________________
Do you Yahoo!?
Yahoo! Finance Tax Center - File online. File on time.
http://taxes.yahoo.com/filing.html
