Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265572AbUEZM7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbUEZM7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265576AbUEZM7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:59:31 -0400
Received: from 0x63.nu ([62.65.122.157]:53219 "EHLO gagarin.0x63.nu")
	by vger.kernel.org with ESMTP id S265572AbUEZM72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:59:28 -0400
Date: Wed, 26 May 2004 14:59:14 +0200
From: Anders Gustafsson <andersg@0x63.nu>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-ID: <20040526125914.GB2629@chernushka>
References: <20040522013636.61efef73.akpm@osdl.org> <20040526124158.GA3679@h55p111.delphi.afb.lu.se> <20040526124944.GQ5322@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526124944.GQ5322@suse.de>
User-Agent: Mutt/1.5.6i
X-Scanner: exiscan *1BSy04-0001Os-00*PugezGjeIoA*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 02:49:44PM +0200, Jens Axboe wrote:
> But they need to be bisabled, since -o barrier doesn't work on SCSI yet.
> Only non-data tagged flushes are supported, those from
> blkdev_issue_flush().

:(

Is the problem in the scsi drivers or at a higher level? Would really
like to have them unbisabled, got a huge speed improvement in a
logging-application with barriers when tested on IDE.

 anders
