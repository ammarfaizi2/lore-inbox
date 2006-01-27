Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWA0H6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWA0H6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 02:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWA0H6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 02:58:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1902 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964829AbWA0H6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 02:58:21 -0500
Date: Fri, 27 Jan 2006 09:00:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Albert Cahalan <acahalan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rmatthias.andree@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060127080026.GR4311@suse.de>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <Pine.LNX.4.61.0601262139290.27891@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601262139290.27891@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26 2006, Jan Engelhardt wrote:
> 
> >You just want the device naming to reflect that. The user should not
> >need to use /dev/hda, but /dev/cdrecorder or whatever. A real user would
> >likely be using k3b or something graphical though, and just click on his
> >Hitachi/Plextor/whatever burner. Perhaps some fancy udev rules could
> >help do this dynamically even.
> 
> And if you have multiple cdwriters? Then (cf. other posts) one has 
> /dev/cdrecorder0 /dev/cdrecrder1, etc. To me, that's just as bad as having 
> /dev/sg0 and /dev/sg1, because you don't have a clue at first sight what it 
> maps to.

/dev/plextorwriter and /dev/hpwriter or whatever, it's just naming.

> "ls -l"? Sure, if cdrecorder0 was a symlink, but it does not work when it's 
> not (= a block device in essence then).
> And I'm sure there's an analog program to "ls" to find what sg0 maps to.

You expect the gui user to follow symlinks to find out?


-- 
Jens Axboe

