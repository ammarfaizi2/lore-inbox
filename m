Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289995AbSBLQ5F>; Tue, 12 Feb 2002 11:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289839AbSBLQ45>; Tue, 12 Feb 2002 11:56:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24836 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289813AbSBLQ4p>;
	Tue, 12 Feb 2002 11:56:45 -0500
Date: Tue, 12 Feb 2002 17:56:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020212175630.O1907@suse.de>
In-Reply-To: <20020212132846.A7966@suse.cz> <3C690E56.3070606@evision-ventures.com> <20020212135701.A16420@suse.cz> <3C6915FC.2020707@evision-ventures.com> <20020212144300.A18431@suse.cz> <3C691F9C.10303@evision-ventures.com> <20020212154251.A25201@suse.cz> <3C693357.8000204@evision-ventures.com> <20020212162834.A25617@suse.cz> <3C69365C.9060603@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C69365C.9060603@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12 2002, Martin Dalecki wrote:
> ide-cdrom stuff, becouse it was always annoying to me that the default
> distribution setup is using the ide interface to my CD-recorder and
> every single recorder aplication out there is using the scsi interface
> instead.

This will soon be a thing of the past, note that the block interface is
capable of passing cdb's around now. So ide-scsi will die, and ATAPI
will no longer be a special case for burning etc.

-- 
Jens Axboe

