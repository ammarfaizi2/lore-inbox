Return-Path: <linux-kernel-owner+w=401wt.eu-S1030464AbXAHS5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbXAHS5r (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 13:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbXAHS5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 13:57:47 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:52522 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030464AbXAHS5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 13:57:46 -0500
X-Originating-Ip: 74.109.98.176
Date: Mon, 8 Jan 2007 13:50:31 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: macros:  "do-while" versus "({ })" and a compile-time error
Message-ID: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  just to stir the pot a bit regarding the discussion of the two
different ways to define macros, i've just noticed that the "({ })"
notation is not universally acceptable.  i've seen examples where
using that notation causes gcc to produce:

  error: braced-group within expression allowed only inside a function

i wasn't aware that there were limits on this notation.  can someone
clarify this?  under what circumstances *can't* you use that notation?
thanks.

rday
