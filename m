Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVBXWkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVBXWkz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVBXWky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:40:54 -0500
Received: from calma.pair.com ([209.68.1.95]:16657 "HELO calma.pair.com")
	by vger.kernel.org with SMTP id S262530AbVBXWkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:40:18 -0500
Date: Thu, 24 Feb 2005 17:40:09 -0500
From: "Chad N. Tindel" <chad@tindel.net>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050224224009.GA66192@calma.pair.com>
References: <20050223230639.GA33795@calma.pair.com> <20050223183634.31869fa6.akpm@osdl.org> <20050224052630.GA99960@calma.pair.com> <421DD5CC.5060106@aitel.hist.no> <20050224173356.GA11593@calma.pair.com> <16926.21614.267728.100131@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16926.21614.267728.100131@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In many Unices, crucial kernel threads run at realtime priority with a
> static priority higher than is accessible to user code.

Yep.  

> That being said, however, you've got to be a privileged user to set
> real time very high priority on a thread, and if you do, you'd better
> know what you're doing.  Any SCHED_FIFO thread should run for a time,
> then sleep for a time, or it *will* DOS everything else on the
> processor.

This is only true if you're not doing what you said in your first paragraph,
i.e. running crucial kernel threads higher than any user thread.

Chad
