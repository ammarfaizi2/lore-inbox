Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292146AbSBOVZB>; Fri, 15 Feb 2002 16:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292145AbSBOVYv>; Fri, 15 Feb 2002 16:24:51 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:17924 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S292146AbSBOVYe>; Fri, 15 Feb 2002 16:24:34 -0500
Date: Fri, 15 Feb 2002 22:24:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE cleanup for 2.5.4-pre3
Message-ID: <20020215222432.A7631@suse.cz>
In-Reply-To: <20020208231346.GA1209@elf.ucw.cz> <20020211094230.E1957@suse.de> <20020211134443.GC20854@atrey.karlin.mff.cuni.cz> <20020211181013.K729@suse.de> <20020213225326.A10409@suse.cz> <20020214094046.B37@toy.ucw.cz> <3C6CC19C.3040608@evision-ventures.com> <20020215204510.GD5019@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020215204510.GD5019@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Fri, Feb 15, 2002 at 09:45:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 09:45:10PM +0100, Pavel Machek wrote:

> My favourite cleanup would be 
> 
> struct ide_drive_s {} ide_drive_t;
> 
> =>
> 
> struct ide_drive {};
> 
> and replacing all ide_drive_t with struct ide_drive...

Well, my favorite would be to kill HWIF() ...

-- 
Vojtech Pavlik
SuSE Labs
