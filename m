Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291579AbSBML2I>; Wed, 13 Feb 2002 06:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291566AbSBML2D>; Wed, 13 Feb 2002 06:28:03 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:47371 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291579AbSBML1u>; Wed, 13 Feb 2002 06:27:50 -0500
Date: Wed, 13 Feb 2002 12:27:48 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Andre Hedrick <andre@linuxdiskcert.org>, Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020213122748.A31528@suse.cz>
In-Reply-To: <20020213074214.S1907@suse.de> <Pine.LNX.4.10.10202122327570.668-100000@master.linux-ide.org> <20020213084756.T1907@suse.de> <3C6A4770.2030709@evision-ventures.com> <20020213120308.Z1907@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020213120308.Z1907@suse.de>; from axboe@suse.de on Wed, Feb 13, 2002 at 12:03:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 12:03:08PM +0100, Jens Axboe wrote:
> On Wed, Feb 13 2002, Martin Dalecki wrote:
> > Jens Axboe wrote:
> > 
> > >The global read-ahead change is surely not what we want. The IDE
> > >cleanups I've seen so far look good to me.
> > >
> > 
> > Ask Alan Cox - even he saw finally that it's just removal of dead code...
> 
> Ok I still need to read it, the concern was just that we want to have
> queue level read-ahead granularity. I'm all for getting rid of the
> horrid arrays we have now.

We can add that in a sane way immediately once these arrays are gone.

-- 
Vojtech Pavlik
SuSE Labs
