Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWB1X5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWB1X5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWB1X5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:57:05 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:11060 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932701AbWB1X5D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:57:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nFb0eUOHISaCApy4TfMNzTPwbwhAm+K5erEn80yQebtJ+gjKcmH3vm6E7SsSpZmS3/5Xojcfj1UVHwUXNBiPOy3zGKtyDQZP+Y8R3PlkciFGL/5AL1SR35aI9wL3UN8aQyHE0LJdG7bflEiM0yk8uUECNorREHNpBCgV6dRdODg=
Message-ID: <9a8748490602281557l4228676chdb59c70b684efbf5@mail.gmail.com>
Date: Wed, 1 Mar 2006 00:57:02 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Laurent Riffard" <laurent.riffard@free.fr>
Subject: Re: 2.6.16-rc5-mm1
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <4404DA29.7070902@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060228042439.43e6ef41.akpm@osdl.org>
	 <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	 <4404CE39.6000109@liberouter.org>
	 <9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	 <4404DA29.7070902@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/06, Laurent Riffard <laurent.riffard@free.fr> wrote:
> Le 28.02.2006 23:30, Jesper Juhl a écrit :
> > On 2/28/06, Jiri Slaby <slaby@liberouter.org> wrote:
> >
> >>-----BEGIN PGP SIGNED MESSAGE-----
> >>Hash: SHA1
> >>
> >>Jesper Juhl napsal(a):
> >>
> >>>Since I'm in X when the lockup happens and I don't have enough time
> >>>from clicking the eclipse icon to the box locks up to make a switch to
> >>>a text console I don't know if an Oops or similar is dumped to the
> >>>console (there's nothing in the locks after a reboot)  :-(
> >>
> >>So why don't just run eclipse from console (DISPLAY=... eclipse), or use atd,
> >>crond... (less common variants)?
> >>
> >
> >
> > Good idea, thanks. Dunno why I didn't think of that.
> >
> > --
> > Jesper Juhl <jesper.juhl@gmail.com>
>
> I experienced similar symptoms while launching mozilla 1.7.12. I
> found that java was the culprit.
>

I can confirm that. I just tried visiting a website, that launches a
java applet, with Firefox 1.5.0.1 which resulted in an instant freeze.
So it seems anything Java is a good test case.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
