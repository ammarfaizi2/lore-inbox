Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314079AbSDQHdK>; Wed, 17 Apr 2002 03:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSDQHdJ>; Wed, 17 Apr 2002 03:33:09 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:32531 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S314079AbSDQHdJ>; Wed, 17 Apr 2002 03:33:09 -0400
Message-ID: <3CBD2527.EB976895@aitel.hist.no>
Date: Wed, 17 Apr 2002 09:32:55 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.8-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <20020415125606.GR12608@suse.de> <02db01c1e498$7180c170$58dc703f@bnscorp.com> <20020416102510.GI17043@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Mon, Apr 15 2002, Aaron Tiensivu wrote:
> > Simple question but hopefully it has a simple answer.. is there a command
> > you can issue or flag you can look for from the output of hdparm to tell if
> > your hard drive is capable of TCQ before installing the patch? I have a few
> > IBM drives that I'm sure have TCQ abilities but I don't trust them as far as
> > I can throw them (being Hungarian and cursed) but I'd like to give TCQ a
> > whirl on my WD 120GB drives that should work OK, if they support TCQ..
> >
> > Sorry if it's already been asked.. :)
> 
> Mark Hahn wrote this little script to detect support for TCQ, modified
> by me to not use the hdX symlinks.

I tried it.  It had to run as root to get permission to read.
Then it hung the machine - caps & scroll lock blinking.

I can retry it without X (and fs'es remounted r/o) _if_ the
resulting crash may help with debugging.

IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)

Helge Hafting
