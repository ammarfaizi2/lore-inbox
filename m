Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbSLEWEe>; Thu, 5 Dec 2002 17:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbSLEWEe>; Thu, 5 Dec 2002 17:04:34 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:27657
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267506AbSLEWEd>; Thu, 5 Dec 2002 17:04:33 -0500
Subject: Re: 2.5: ext3 bug or dying drive?
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DEFCD3A.29C98E8D@digeo.com>
References: <1039123660.1433.12.camel@phantasy>
	 <3DEFCD3A.29C98E8D@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1039126335.1942.32.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 05 Dec 2002 17:12:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-05 at 17:03, Andrew Morton wrote:

> Were there no I/O error messages reported from the device driver,
> block, buffer or pagecache layer?  Generally everyone like to have
> a shout as one flies past.

Nope.  Odd, eh?

Only log item of relevance was

	(scsi0:A:0:0): Locking max tag count at 64

which I get every now and then anyhow.

> It would be useful to give the IO system a bit of a thrashing,
> to narrow the problem down.  Just a `cat /dev/sda[n] > /dev/null'
> would suit.

2.4 survived this fine.  Looking like its not the disk, then.  I will
try this in 2.5 once I backup some data and finish some work.

I should note I have been running this machine with 2.5 for about a
month now with no problems and my development machines have been 2.5
since, uh, 2.5.1 but they are all IDE not SCSI.

> Bottom line: dunno.

Me neither.  Quite an anomaly.

	Robert Love

