Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWE3WzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWE3WzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWE3WzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:55:24 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:55208 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932533AbWE3WzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:55:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jJztcq1n75JxI4QW4sSGesFX8KPdIeYaSpJqtZwgQBiNb37zAhP9Z4Vl5uQyVMAGE+zP4oQ2iz1a8QB/mrmafXz5eG24ELR7LV+SBFrl21zIB/7poGQ6S3Qq/eFhuV6+7lS89K0Ip4OdbxUALrnTiEnhAKG/41pkbdtqAZVKtV4=
Message-ID: <9e4733910605301555o287cbd18i99c8813ca6592494@mail.gmail.com>
Date: Tue, 30 May 2006 18:55:22 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Ondrej Zajicek" <santiago@mail.cz>
Subject: Re: OpenGL-based framebuffer concepts
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060530223513.GA32267@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
	 <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>
	 <20060530223513.GA32267@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, Ondrej Zajicek <santiago@mail.cz> wrote:
> On Tue, May 30, 2006 at 10:40:20AM -0700, David Lang wrote:
> > as a long time linux user I tend to not to use the framebuffer, but
> > instead use the standard vga text drivers (with X and sometimes dri/drm).
> >
> > in part this dates back to my early experiances with the framebuffer code
> > when it was first introduced, but I still find that the framebuffer is not
> > as nice to use as the simpler direct access for text modes. and when I
> > start X up it doesn't need a framebuffer, so why suffer with the
> > performance hit of the framebuffer?
>
> Many users want to use text mode for console. But this request is not
> in contradiction with fbdev and fbcon. It just requires to do some work:

My thoughts are mixed on continuing to support text mode for anything
other than initial boot/install. Linux is all about multiple languages
and the character ROMs for text mode don't support all of these
languages. Moving towards only bitmapped consoles means that all the
Unicode languages can be made available with a standard API. This is
an area that deserves more discussion.

-- 
Jon Smirl
jonsmirl@gmail.com
