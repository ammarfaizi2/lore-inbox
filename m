Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292473AbSCEWfF>; Tue, 5 Mar 2002 17:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292293AbSCEWef>; Tue, 5 Mar 2002 17:34:35 -0500
Received: from dsl-213-023-039-135.arcor-ip.net ([213.23.39.135]:17570 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292320AbSCEWeR>;
	Tue, 5 Mar 2002 17:34:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Tue, 5 Mar 2002 23:29:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Jeremy Higdon <jeremy@classic.engr.sgi.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <E16hwzT-0000et-00@starship.berlin> <20020305074042.GB716@suse.de>
In-Reply-To: <20020305074042.GB716@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16iNRL-0002lD-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 5, 2002 08:40 am, Jens Axboe wrote:
> On Mon, Mar 04 2002, Daniel Phillips wrote:
> > > FUA is not available on WRITE6, only WRITE10 or WRITE12 commands.
> > 
> > I'm having a little trouble seeing the difference between WRITE10, WRITE12
> > and WRITE16.  WRITE6 seems to be different only in not garaunteeing to 
> > support the FUA (and one other) bit.  I'm reading the Scsi Block Commands
> 
> WRITE6 was deprecated because there is only one byte available to set
> transfer size. Enter WRITE10. WRITE12 allows the use of the streaming
> performance settings, that's the only functional difference wrt WRITE10
> iirc.

Thanks.  This is poorly documented, to say the least.

> > (Side note: how nice it would be if t10.org got a clue and posted their
> > docs in html, in addition to the inconvenient, unhyperlinked, proprietary
> > format pdfs.)
> 
> See the mtfuji docs as an example for how nicely pdf's can be setup too.

Do you have a url?

> The thought of substituting that for a html version makes me want to
> barf.

Who said substitute?  Provide beside, as is reasonable.  For my part,
pdf's tend to cause severe indigestion, if not actually cause
regurgitation.

-- 
Daniel
