Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWGYT2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWGYT2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWGYT2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:28:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:52982 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964847AbWGYT2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:28:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kRGEKL+xaIBzsE+s5LpdlxAoxYw7/ZaMdb73g9A8r3p1jGO4cS8sJ/269LbQQZufgplAb2Ftjk/cuXnTNTzxJxZ5Yb/MGYOkmlOmLAjZeHm4jV0gYUXjzxbmremT7ATUVPeAIhjFI8D+YE9ya1ZJO5hZgfZRK4pan3GOpCY+13g=
Message-ID: <f96157c40607251228t457f445qd12f80d4e6ee363b@mail.gmail.com>
Date: Tue, 25 Jul 2006 21:28:48 +0200
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: Re: i686 hang on boot in userspace
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060725192138.GD4044@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f96157c40607250128h279d6df7n8e86381729b8aa97@mail.gmail.com>
	 <f96157c40607250217o1084b992u78083353032b9abc@mail.gmail.com>
	 <f96157c40607250220h13abfd6av2b532cae70745d2@mail.gmail.com>
	 <f96157c40607250235t4cdd76ffxfd6f95389d2ddbdc@mail.gmail.com>
	 <20060725112955.GR4044@suse.de>
	 <f96157c40607250547m5af37b4gbab72a2764e7cb7c@mail.gmail.com>
	 <20060725125201.GT4044@suse.de>
	 <f96157c40607250750n5aa08856jbe792b0e66fb814b@mail.gmail.com>
	 <f96157c40607251158x29f9632ey85d371a1a5a074b8@mail.gmail.com>
	 <20060725192138.GD4044@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> On Tue, Jul 25 2006, gmu 2k6 wrote:
> > thanks Jens,
> > 7b30f09245d0e6868819b946b2f6879e5d3d106b
> > http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7b30f09245d0e6868819b946b2f6879e5d3d106b
> > has fixed the problem (maybe together with the other 3 changes in HEAD
> > as the 2nd patch in this thread did not work in the first place or maybe
> > it is a little bit different, no time to check right now).
>
> It's an identical change, so the one sent you should work as well.
> Perhaps you botched that one test? These things happen, it's happened to
> me as well :-)
>
> The change definitely fixed it for me.

here too. right now I'm busy with trying to find out why /dev/hwrng is
present but does not pass rngtest checks. I'll post about that soonish
but it's a different issue of course.

anyway, thanks a lot Jens.
