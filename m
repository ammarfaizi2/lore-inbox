Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266767AbUGLJVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266767AbUGLJVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 05:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUGLJVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 05:21:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18626 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266767AbUGLJVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 05:21:13 -0400
Date: Mon, 12 Jul 2004 11:20:32 +0200
From: Jens Axboe <axboe@suse.de>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT][HELP]: cdrecord and /dev/hdc on SuSE 9.1
Message-ID: <20040712092032.GI10402@suse.de>
References: <200407092245.31700.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407092245.31700.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09 2004, R. J. Wysocki wrote:
> Hi,
> 
> Can anyone please tell me how to make cdrecord that is shipped with
> SuSE 9.1 work with something like /dev/hdc _without_ ide-scsi?  I'm
> having strange problems with cdrecord which is hanging my system
> sollid that I'd like to reproduce without the SCSI-related stuff
> getting in the way.

If you use /dev/hdc, you cannot by definition be using ide-scsi at the
same time.

-- 
Jens Axboe

