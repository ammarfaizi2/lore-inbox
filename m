Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbTDGAQT (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 20:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbTDGAQT (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 20:16:19 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:32775
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263164AbTDGAQT 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 20:16:19 -0400
Subject: Re: 2.5: NFS troubles
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, felipe_alfaro@linuxmail.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030406171855.6bd3552d.akpm@digeo.com>
References: <1049630768.592.24.camel@teapot.felipe-alfaro.com>
	 <shsbrzjn5of.fsf@charged.uio.no>  <20030406171855.6bd3552d.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049675270.753.166.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 06 Apr 2003 20:27:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-06 at 20:18, Andrew Morton wrote:

> if it shows dir_index then it might be an ext3 problem.  If not then it is
> probably an NFS problem.

Nah, its not an ext3 problem (at least not with htree).

I am seeing this same problem, starting recently, with a 2.5 client and
a 2.4 server.  Both are ext3 but neither have htree, and the problem is
new.

I have not yet figured out whether its the 2.5 kernel on the client or
the newly-upgraded Red Hat 9 on the server... but I suspect the 2.5
kernel on the client.

	Robert Love

