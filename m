Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279005AbRKICIv>; Thu, 8 Nov 2001 21:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279106AbRKICIl>; Thu, 8 Nov 2001 21:08:41 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:48369
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279005AbRKICIY>; Thu, 8 Nov 2001 21:08:24 -0500
Date: Thu, 8 Nov 2001 18:08:18 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
Message-ID: <20011108180818.A23814@mikef-linux.matchmail.com>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011108173458.C14468@mikef-linux.matchmail.com> <Pine.LNX.4.40.0111081752260.1501-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0111081752260.1501-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 06:09:29PM -0800, Davide Libenzi wrote:
> On Thu, 8 Nov 2001, Mike Fedyk wrote:
> 
> > > The MQ scheduler has the same roots of the proposed one but has a longest
> > > fast path due the try to make global scheduling decisions at every
> > > schedule.
> >
> > Ahh, so that's why it hasn't been adopted...
> 
> Changing the scheduler is not easy ( not to code patches but to make
> everyone agree on the need of changing it ) and as i already said, it's
> easier to force my cat to have a bath instead of Linus to change the
> scheduler :)
>

Hmm, let's see...  You go to the trouble to keep to code tight, and cache
optimized, even raid5 is choosing a little slower implementation for better
cache properties, and then you go and kill it all with the scheduler...
Yep, that makes sence. ;)

Mike
