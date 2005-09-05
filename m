Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbVIEUsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbVIEUsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 16:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVIEUsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 16:48:35 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:4872 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932516AbVIEUsf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 16:48:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ye0XryJQtWApUcDq+YdVRKWY7AtMAiG8Gajw2AMeTCm6QtcAy1gYFiiBU+oH7oGUHgzI8vQuoc6AWuh/TFNMcCWlTMQ7Ta/rGwbf1D43hwlMYIbiVJehHZsQcIBb3y5XWJq5uEXOu089DI2a6ywTO3YETpIFIshHdP3/1V8A/Gw=
Message-ID: <9a87484905090513481118e67b@mail.gmail.com>
Date: Mon, 5 Sep 2005 22:48:32 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Bret Towe <magnade@gmail.com>
Subject: Re: nfs4 client bug
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <dda83e78050905134420f06fbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dda83e78050903171516948181@mail.gmail.com>
	 <dda83e7805090320053b03615d@mail.gmail.com>
	 <20050904103523.GA5613@electric-eye.fr.zoreil.com>
	 <dda83e78050904124454fc675a@mail.gmail.com>
	 <dda83e78050904135113b95c4a@mail.gmail.com>
	 <20050904215219.GA9812@fieldses.org>
	 <dda83e780509042008294fbe26@mail.gmail.com>
	 <20050905031825.GA22209@fieldses.org>
	 <dda83e78050905134420f06fbf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, Bret Towe <magnade@gmail.com> wrote:
> On 9/4/05, J. Bruce Fields <bfields@fieldses.org> wrote:
> > On Sun, Sep 04, 2005 at 08:08:22PM -0700, Bret Towe wrote:
> > > On 9/4/05, J. Bruce Fields <bfields@fieldses.org> wrote:
> > > > Do you get anything from alt-sysrq-T?
> > >
> > > no i havent used that im usally in x when its freezing
> > > x wont even switch to console would it still give me anything then?
> >
> > Well, you can try something like:
> >         alt-sysrq-T
> > wait a couple seconds, then
> >         alt-sysrq-S
> >         alt-sysrq-U
> >         alt-sysrq-B
> > with maybe a second between each to give stuff a chance to get to disk.
> >
> > Then if you're lucky you may find the stack dumps in your log after you
> > reboot.
> 
> tried it and so far no luck ill keep trying a few more times and see
> if i can get it
> to spit somethin out to disk but i dont think ill be that lucky as that would
> prob make life to easy wouldnt it?

How about 

serial console over a cross-over cable to a second box.
netconsole will let you put the console on a different box over the network.
console on line printer will let you have a permanent record of the
console output on paper.

See
 Documentation/serial-console.txt
 Documentation/networking/netconsole.txt
 the help entry for "config LP_CONSOLE" (in drivers/char/Kconfig)

Would any of those perhaps help you in capturing anything ?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
