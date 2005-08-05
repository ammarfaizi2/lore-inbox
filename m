Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVHEPKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVHEPKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVHEPHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:07:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:33688 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262307AbVHEPFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:05:43 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17139.32831.571021.34524@tut.ibm.com>
Date: Fri, 5 Aug 2005 10:05:35 -0500
To: Jens Axboe <axboe@suse.de>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com, prasadav@us.ibm.com
Subject: Re: [-mm patch] relayfs: add read() support
In-Reply-To: <20050805144926.GS5561@suse.de>
References: <17138.53203.430849.147593@tut.ibm.com>
	<20050805144926.GS5561@suse.de>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
 > On Thu, Aug 04 2005, Tom Zanussi wrote:
 > > At the kernel summit, there was some discussion of relayfs and the
 > > consensus was that it didn't make sense for relayfs to not implement
 > > read().  So here's a read implementation...
 > 
 > It needs a few fixes to actually compile without errors. This works for
 > me, just tested with the block tracing stuff, works a charm!

Great, glad to hear it!  I should have noted in the posting, though,
that you should first apply the 'API cleanup' patch, in which case you
shouldn't get the compile errors.

Tom


