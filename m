Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWH3Cam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWH3Cam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 22:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWH3Cam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 22:30:42 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:39608 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932407AbWH3Cal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 22:30:41 -0400
Subject: Re: megaraid_sas suspend ok, resume oops
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sreenivas.Bagalkote@lsil.com,
       Sumant.Patro@lsil.com, jeff@garzik.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <b6a2187b0608291845l17532458hf0aaf22e247b5b37@mail.gmail.com>
References: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com>
	 <20060829081518.GD12257@kernel.dk>
	 <b6a2187b0608290522vea22930y54ac39bfce3127f2@mail.gmail.com>
	 <1156895131.3232.25.camel@nigel.suspend2.net>
	 <b6a2187b0608291845l17532458hf0aaf22e247b5b37@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 12:30:14 +1000
Message-Id: <1156905015.3243.1.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2006-08-30 at 09:45 +0800, Jeff Chua wrote:
> On 8/30/06, Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> >
> > Neither swsusp (as far as I know) or suspend2 support CONFIG_HIGHMEM64G
> > at the moment, I'm afraid.
> >
> > It's not impossible, we just haven't seen it as a priority worth putting
> > time into. Do you really have more than 4GB of RAM and want to suspend
> > to disk?
> 
> It'll be really "nice" to have. Currently all the production systems
> simply shutdown all databases and applications and put systems to a
> halt. But, I'm thinking of implementing suspend_to_disk instead of
> shutdown the database and applications, so when power resumes, the
> system can carry on where it was left off. Nice, very nice feature to
> have.
> It's "nice" because nobody has tried, and if this works, I don't see
> why not use it for all machines in a data center.
> 
> The DELL 2950 has 16GB of RAM, and will be running oracle database.

Ok. I'll give it a go then, but I'll tell you now that it will probably
take a while as I have a lot on my plate. Feel free to poke me :)

Nigel

