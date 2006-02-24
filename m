Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWBXV3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWBXV3a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWBXV3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:29:30 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:29157 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932537AbWBXV33 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:29:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SaziXI3eP1nXjTq0LsAzB/Wy1ewausASVhLMFx4JrxWyr418s5lqAEW0WFDEpnF2hvd9xX8zodFCtxf6ra1+sUykP4f+z7Zzrw+gLp05B8YkJ6LSYcB4RtAEk2qgmyMSefgm1B/9c/Cvcj/FCsyevlHXPc5C1bRccfuolwQYyHY=
Message-ID: <9a8748490602241329i1200a95docdbfd17da7ee0cbb@mail.gmail.com>
Date: Fri, 24 Feb 2006 22:29:28 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: gene.heskett@verizononline.net
Subject: Re: Weird login, possibly related to rootkit Q
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200602241610.08952.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602230121.08670.gene.heskett@verizon.net>
	 <20060224190409.GB9384@kvack.org>
	 <200602241610.08952.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/06, Gene Heskett <gene.heskett@verizon.net> wrote:
> On Friday 24 February 2006 14:04, Benjamin LaHaise wrote:
> >On Thu, Feb 23, 2006 at 01:21:07AM -0500, Gene Heskett wrote:
> >> So we did a reinstall (rh9) without formatting because there was a
> >> lot of non-replaceable data on it.  This also saved the logs, but
> >> they are obviously not a lot of help when about 5 hours is missing
> >> at about the time everything went to hell.
> >
> >Let's get this straight: your old Linux distro got rooted, so you
> > installed an old Linux distro that no longer gets security updates to
> > replace it. Why is that kernel related?  Sounds more like pebkac.
>
> The version of php in the newer distros is not backards compatible and
> breaks most of the scripts used by the web page server (this box is its
> database) and that would require a lengthy rewrite of the php stuff on
> both machines, so the re-install of rh9 was the perceived easiest way
> out.  Its a commercial business whose web page gets 20k+ hits a day &
> downtime shouldn't be extended 2-3 days while re-writeing all of that
> as it took around 2 weeks to do it all originally.  Then at the end of
> the install, we edited the yum.conf to use the legacy servers and let
> it install/upgrade everything, a Gigabyte or so.
>
> Had the php for say FC4 been backwards compatible, then obviously we
> would have taken a different path.  I don't think the yum.conf had been
> updated or installed even before this, and apt-get had, with its old
> paths in its config, also quit working quite some time back.
>

ehh, how about

1. Install newer up-to-date distro
2. install custom build old version of PHP.

still quick way to get going and you'd get the bennefit of lots of
fixes in the distro (even if your PHP would still be quite old)...

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
