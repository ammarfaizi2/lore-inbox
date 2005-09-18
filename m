Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbVIRA6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVIRA6f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 20:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVIRA6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 20:58:35 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:41498 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751258AbVIRA6e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 20:58:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BtqHvkQDp5VS5qMS0Z7HXVqGfV01BADegfZp79Dt2uRVqRLQ+poiY9QK4oINg2OwJoyT9CJIR/qfDM5Qr4M3FG853dnZeiXSlu6eqn0kHqJGEb8buqq+ADvf7YOLBipcZayhfwo0tahInIyX8C/WifR6W6Rw2ninL3cJORP2+pg=
Message-ID: <9a87484905091717587e35b9e7@mail.gmail.com>
Date: Sun, 18 Sep 2005 02:58:31 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Why don't we separate menuconfig from the kernel?
Cc: khc@pm.waw.pl, linux-kernel@vger.kernel.org
In-Reply-To: <20050917175624.6637140d.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <m364szk426.fsf@defiant.localdomain>
	 <9a874849050917174635768d04@mail.gmail.com>
	 <20050917175624.6637140d.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Sun, 18 Sep 2005 02:46:35 +0200 Jesper Juhl wrote:
> 
> > On 17 Sep 2005 19:16:33 +0200, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> > > Hi,
> > >
> > > A number of packages (e.g., busybox) use some, more or less broken,
> > > version of menuconfig. Would it make sense to move menuconfig to
> > > a separate well-defined package?
> > >
> >
> > What exactely is it you want to make a sepperate package?
> >
> > menuconfig is just a little bit of the kbuild system which also
> > includes xconfig, config, gconfig, oldconfig, etc.  menuconfig is just
> > a dialog based frontend to the kbuild system which consists of
> > configuration options, help texts, dependency info etc.
> >
> > menuconfig uses `dialog` to present its menus and dialog boxes (using
> > ncurses), and if you want to build something else using dialog, then
> > that already exists as a sepperate program that has nothing to do with
> > kbuild. On my system (Slackware) it's installed as /bin/dialog and
> > comes from the pkgtools-10.2.0-i486-5 package.
> >
> > I don't think it makes much sense to split the parts of kbuild that
> > make up menuconfig out into a standalone thing. kbuild (and thus
> > menuconfig) has little use outside the kernel.  The `dialog` tool is a
> > different matter, but that is already a sepperately developed thing (
> > http://hightek.org/dialog/ ) .
> 
> OTOH, Christoph Hellwig used to maintain 'mconf' out-of-tree
> and it worked decently, so it seems not a big deal to so do.
> 
I still fail to see the point of doing so, even if doable.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
