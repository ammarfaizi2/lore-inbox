Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129068AbQJ1Uih>; Sat, 28 Oct 2000 16:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131333AbQJ1Ui1>; Sat, 28 Oct 2000 16:38:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6152 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129068AbQJ1UiX>;
	Sat, 28 Oct 2000 16:38:23 -0400
Date: Sat, 28 Oct 2000 13:40:56 -0700
From: Jens Axboe <axboe@suse.de>
To: Hisaaki Shibata <shibata@luky.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
Message-ID: <20001028134056.J3919@suse.de>
In-Reply-To: <20001024162112.A520@suse.de> <20001028141056T.shibata@luky.org> <20001028000448.D3919@suse.de> <20001028232703S.shibata@luky.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28 2000, Hisaaki Shibata wrote:
> > > But I could not mkudf nor mkext2fs to my ATAPI 9.4GB new DVD-RAM drive.
> > 
> > What do you mean? What happened? strace of mke2fs of mkudf would
> > be nice to have.
> 
> My system said it is not permited because it is read only.

[snip]

Ok, does /proc/sys/dev/cdrom/info list DVD-RAM as a capability?

> And  /proc/ide/hdc/media says "cdrom". Is it OK?

Yes, that is fine.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
