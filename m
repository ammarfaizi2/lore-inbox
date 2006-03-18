Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWCRXW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWCRXW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 18:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWCRXW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 18:22:26 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:32234 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751128AbWCRXWZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 18:22:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I8/WVNKph1sJ86kGZvVG8tRONOjkVzvPQNnCXDHBYVkXgCrc71tpR4ug9s5zpYY4L366PNfDPiPtrLfn+uK2rbFOqYZiWzDL8UAooVIQf09m/LHs+URyRDkkOrR8S/tca5NsozBuZkIW5jyMb6J2vXl/kUk2/AiJenIrUIUmmHg=
Message-ID: <9a8748490603181522s113cd1acn20d97da825c4fd7@mail.gmail.com>
Date: Sun, 19 Mar 2006 00:22:24 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "James Bottomley" <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] fix potential return of uninitialized variable in scsi_scan (resend)
Cc: linux-kernel@vger.kernel.org, "Eric Youngdale" <eric@andante.org>,
       linux-scsi@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1142723433.3773.16.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603182242.52507.jesper.juhl@gmail.com>
	 <1142723433.3773.16.camel@mulgrave.il.steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/06, James Bottomley <James.Bottomley@hansenpartnership.com> wrote:
> On Sat, 2006-03-18 at 22:42 +0100, Jesper Juhl wrote:
> > ( The patch below was already send on March 9, 2006. )
> > ( This is a resend, re-diff'ed against 2.6.16-rc6    )
> >
> >
> > The coverity checker found out that we potentially return sdev uninitialized.
> > This should fix coverity #879
>
> The fix for this is already in scsi-misc.
>
Ok, I was unaware of that.
I'll try to remember to check that git tree in the future.

Thanks.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
