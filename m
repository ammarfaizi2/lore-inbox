Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292116AbSBYXcJ>; Mon, 25 Feb 2002 18:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292406AbSBYXcB>; Mon, 25 Feb 2002 18:32:01 -0500
Received: from mercury.mv.net ([199.125.85.40]:35055 "EHLO mercury.mv.net")
	by vger.kernel.org with ESMTP id <S292402AbSBYXbn>;
	Mon, 25 Feb 2002 18:31:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tom Rauschenbach <tom@rauschenbach.mv.com>
To: Mike Fedyk <mfedyk@matchmail.com>, Dan Maas <dmaas@dcine.com>
Subject: Re: ext3 and undeletion
Date: Mon, 25 Feb 2002 18:33:01 -0500
X-Mailer: KMail [version 1.2]
Cc: "Rose, Billy" <wrose@loislaw.com>, linux-kernel@vger.kernel.org
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <20020225172048.GV20060@matchmail.com>
In-Reply-To: <20020225172048.GV20060@matchmail.com>
MIME-Version: 1.0
Message-Id: <02022518330103.01161@grumpersII>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 February 2002 12:20, Mike Fedyk wrote:
> On Mon, Feb 25, 2002 at 12:06:29PM -0500, Dan Maas wrote:
> > > but I don't want a Netware filesystem running on Linux, I
> > > want a *native* Linux filesystem (i.e. ext3) that has the
> > > ability to queue deleted files should I configure it to.
> >
> > Rather than implementing this in the filesystem itself, I'd first try
> > writing a libc shim that overrides unlink(). You could copy files to
> > safety, or do anything else you want, before they actually get deleted...
>
> Yep, more portable.



But it only works if everything get linked with the new library.

>
> Now the question is: Is there already something written?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
