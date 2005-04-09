Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVDIWSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVDIWSI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 18:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVDIWSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 18:18:08 -0400
Received: from hera.kernel.org ([209.128.68.125]:9702 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261395AbVDIWSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 18:18:04 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Status of new kernel.org servers
Date: Sat, 9 Apr 2005 22:17:49 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <d39kad$a33$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1113085069 10340 127.0.0.1 (9 Apr 2005 22:17:49 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 9 Apr 2005 22:17:49 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those of you that are interested...

The second new kernel.org server, named, ironically enough,
zeus1.kernel.org went into the racks and, shortly thereafter, into
production Friday.  The only service that isn't served from both
servers at this time is mirrors.kernel.org for the simple reason that
it's still syncing on zeus1; it will probably be turned on early next
week.

As a consequence, all kernel.org services are now round-robin between
two hosts.  You can also hit a specific host by appending a digit,
e.g. ftp1.kernel.org, or mirrors2.kernel.org.

When one server is offline, we'll change the round-robin names to only
point to the one host that is in operation.

As some of you noticed, there was a problem early on which made
uploads lag behind; it has now been corrected and uploads should be
significantly faster than they have been in a long time.

As usual, please report problems to ftpadmin@kernel.org.  As far as we
know, the transition problems have been taken care of and all should
be well.

	-hpa

P.S. Again, thanks to HP for the new servers and to ISC for hosting
them.
