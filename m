Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133053AbRBEPkH>; Mon, 5 Feb 2001 10:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133078AbRBEPj5>; Mon, 5 Feb 2001 10:39:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59656 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S133053AbRBEPju>;
	Mon, 5 Feb 2001 10:39:50 -0500
Date: Mon, 5 Feb 2001 16:39:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, rbrito@iname.com
Subject: Re: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't work)
Message-ID: <20010205163931.I5285@suse.de>
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org> <20010205020952.B1276@suse.de> <20010205013424.A15384@iname.com> <20010205144043.H849@nightmaster.csn.tu-chemnitz.de> <20010205163024.A19399@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010205163024.A19399@win.tue.nl>; from dwguest@win.tue.nl on Mon, Feb 05, 2001 at 04:30:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05 2001, Guest section DW wrote:
> I missed the original post, but there is a mount flag "-o speed="
> for precisely this purpose.

Hah, this I did not know. Checking the util-linux source, it might
be a really good idea to not about if setting the speed fails.
This will happen quite often on cd-r/w or dvd drives.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
