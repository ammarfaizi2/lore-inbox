Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWBZN3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWBZN3K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 08:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWBZN3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 08:29:10 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:37523 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751122AbWBZN3J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 08:29:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TVekUYrTgO5KudGa/QPn3wjcNRIY2C0SedDGrw6JsNNQOq6/zHWXBZmwM3eH6LBbaGQyzUuidsYZVtscDLpeREnP3S2SALBVlwJMYF9PaLSIzzmrLadIoletIs9u0UXdyFEW8mRnD+MbDxg4s07uV43+rHWNO7RKQoibxtWT4e8=
Message-ID: <9a8748490602260529h3a2890bhce4112feefb7cb1f@mail.gmail.com>
Date: Sun, 26 Feb 2006 14:29:08 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: Luke-Jr <luke@dashjr.org>
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works ;)
Cc: "Bernhard Rosenkraenzer" <bero@arklinux.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200602261330.15709.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602250042.51677.bero@arklinux.org>
	 <200602261330.15709.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Luke-Jr <luke@dashjr.org> wrote:
> On Friday 24 February 2006 23:42, Bernhard Rosenkraenzer wrote:
> > I've just released dvdrtools 0.3.1
> > (http://www.arklinux.org/projects/dvdrtools/). It is a fork of cdrtools
> > that (as the name indicates) adds support for writing to DVD-R and DVD-RW
> > disks using purely Free Software,
>
> also DVD+R/RW/DL, I hope?
>

And what about DVD-RAM drives? Any plans to support those?

> > that tries to do things the Linux way ("dvdrecord dev=/dev/cdrom
> > whatever.iso")
>
> Shouldn't that be "dvdrecord whatever.iso /dev/cdrom" or similar?

I'd agree, that would match 'cp', 'mv', 'ln' etc by having the source
first and destination second.


> Any plans to support growing an ISO fs (ala growisofs)? Maybe by simply
> including a modified growisofs using dvdrecord-libscg?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
