Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130831AbRCJCLt>; Fri, 9 Mar 2001 21:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130832AbRCJCLj>; Fri, 9 Mar 2001 21:11:39 -0500
Received: from monolith.eradicator.org ([64.81.135.24]:38310 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S130831AbRCJCLc>;
	Fri, 9 Mar 2001 21:11:32 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12 and ac13 breaks usb-visor
In-Reply-To: <E14aQA9-0001br-00@the-village.bc.nu> <20010307172056.A8647@austin.rr.com> <20010307173640.A14818@kroah.com> <20010308140103.A17993@austin.rr.com> <20010308160758.A16296@kroah.com> <20010309141332.A29339@austin.rr.com> <20010309133112.A17792@kroah.com>
From: David Huggins-Daines <dhd@eradicator.org>
Organization: None worth mentioning
Date: 09 Mar 2001 21:10:32 -0500
Message-ID: <871ys6xtk7.fsf@monolith.eradicator.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Fri, Mar 09, 2001 at 02:13:32PM -0600, Erik DeBill wrote:
> > Until it's documented this is a landmine.  JE is the default USB
> > driver, so you can bet that a great many people will be using it (even
> > though it's described as "alternate").  Once it's fixed we just pull
> > the warning from Config.help.
> 
> No, JE is _NOT_ the default USB UHCI driver, it doesn't say so in the
> menu or anywhere.  It's just another option.

It's the one listed in arch/i386/defconfig.  Of course, it's debatable
whether that actually means 'default' or not (since in fact it's more
like 'what Linus uses'), but plenty of people will see it as such.

-- 
David Huggins-Daines              -                     dhd@pobox.com
                      http://www.pobox.com/~dhd/
