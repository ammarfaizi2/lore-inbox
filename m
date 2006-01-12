Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161356AbWALWLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161356AbWALWLw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161357AbWALWLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:11:52 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:57098 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161356AbWALWLv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:11:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VGSE57LyPRLXRqjO5NgF2r9Mcb1aqsCJFc6AQXftJAUy6HUAeydineAaGse5AIBc3KQdBFDoTara9/E3sazwwWgs1UlQHR7+jBzRJQjTQLAfh3+h4fk811+dbM4rH9F+ai/ZwDF1QplA3Ql9UIFFWwLxHqe+CqPbm6z7szTCzqA=
Message-ID: <d120d5000601121411h3706de2cy3d84b52a1d6a42a1@mail.gmail.com>
Date: Thu, 12 Jan 2006 17:11:50 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andrew Morton <akpm@osdl.org>
Subject: Re: git status (was: drm tree for 2.6.16-rc1)
Cc: Linus Torvalds <torvalds@osdl.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       David Woodhouse <dwmw2@infradead.org>, Jens Axboe <axboe@suse.de>,
       Steven French <sfrench@us.ibm.com>, Roland Dreier <rolandd@cisco.com>,
       Wim Van Sebroeck <wim@iguana.be>, Anton Altaparmakov <aia21@cantab.net>,
       Dominik Brodowski <linux@dominikbrodowski.net>
In-Reply-To: <20060112134255.29074831.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0601120948270.1552@skynet>
	 <Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
	 <20060112134255.29074831.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/06, Andrew Morton <akpm@osdl.org> wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> >
> >
> > On Thu, 12 Jan 2006, Dave Airlie wrote:
> > >
> > > Hi Linus,
> > >     Can you pull the drm-forlinus branch from
> > > git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git
> > >
> > > This is a pretty major merge over of DRM CVS, and every driver in the DRM
> > > is brought up to latest versions....
> >
> > I'm actually somewhat inclined to not pull any more. We've had lots of
> > (hopefully minor) issues for the last few days, and I know that people
> > had DRM issues with the -mm tree (which I assume tracked this tree) not
> > more than a week or so ago.
>
> iirc that was AGP.  DRM had a few won't-compile problems, now fixed.
>
> So I think we could squeeze DRM in, but yes, it's getting to that time.
>

I would like to merge psmouse resync patch before -rc1 is out (I have
fixed issues with Frank Sorenson's touchpad and we really need it so
KVMs will be finally useful). The only thing is that I feel like shit
so I am not sure if I will be able to prepare the pull/patch today.

--
Dmitry
