Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269021AbUIHD2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269021AbUIHD2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269022AbUIHD2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:28:17 -0400
Received: from pat.uio.no ([129.240.130.16]:14501 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S269021AbUIHD2P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:28:15 -0400
Subject: Re: [CHECKER] possible deadlock in 2.6.8.1 lockd code
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Dawson Engler <engler@coverity.dreamhost.com>
Cc: linux-kernel@vger.kernel.org, developers@coverity.com
In-Reply-To: <Pine.LNX.4.58.0409071956380.6778@coverity.dreamhost.com>
References: <Pine.LNX.4.58.0409071956380.6778@coverity.dreamhost.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1094614084.21293.69.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 07 Sep 2004 23:28:05 -0400
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 07/09/2004 klokka 22:57, skreiv Dawson Engler:
> Hi All,
> 
> below is a possible deadlock in the linux-2.6.8.1 lockd code found by a
> static deadlock checker I'm writing.  Let me know if it looks valid and/or
> whether the output is too cryptic.  (Note, the locking dependencies go
> across a bunch of function calls, so the paths may be infeasible.)

Are you proposing to help us multi-thread lockd? 8-)

Cheers,
  Trond

