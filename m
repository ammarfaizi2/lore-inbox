Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291560AbSBMLDx>; Wed, 13 Feb 2002 06:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291559AbSBMLDo>; Wed, 13 Feb 2002 06:03:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6151 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291560AbSBMLDb>;
	Wed, 13 Feb 2002 06:03:31 -0500
Date: Wed, 13 Feb 2002 12:03:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Andre Hedrick <andre@linuxdiskcert.org>, Vojtech Pavlik <vojtech@suse.cz>,
        Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020213120308.Z1907@suse.de>
In-Reply-To: <20020213074214.S1907@suse.de> <Pine.LNX.4.10.10202122327570.668-100000@master.linux-ide.org> <20020213084756.T1907@suse.de> <3C6A4770.2030709@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6A4770.2030709@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13 2002, Martin Dalecki wrote:
> Jens Axboe wrote:
> 
> >The global read-ahead change is surely not what we want. The IDE
> >cleanups I've seen so far look good to me.
> >
> 
> Ask Alan Cox - even he saw finally that it's just removal of dead code...

Ok I still need to read it, the concern was just that we want to have
queue level read-ahead granularity. I'm all for getting rid of the
horrid arrays we have now.

-- 
Jens Axboe

