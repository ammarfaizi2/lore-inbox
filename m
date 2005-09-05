Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVIEDI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVIEDI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 23:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVIEDI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 23:08:28 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:13540 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932152AbVIEDI1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 23:08:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W0pF71kp6BJL0hlu4Isb8W+90WQJich1s6IyntF38mk4ZauApcUUW2V7FfziyACLShKVL+ChBPRAoUTiHKro0t6/lCPr6RxYmaT40xBj7YU6FW5+z8AmKWBfKigrpBj6p6PDC9Lx+kbbPg/7hEl6WY7rLNI1OAtWmQwr+qL+noE=
Message-ID: <dda83e780509042008294fbe26@mail.gmail.com>
Date: Sun, 4 Sep 2005 20:08:22 -0700
From: Bret Towe <magnade@gmail.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: nfs4 client bug
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050904215219.GA9812@fieldses.org>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Sun, Sep 04, 2005 at 01:51:08PM -0700, Bret Towe wrote:
> > On 9/4/05, Bret Towe <magnade@gmail.com> wrote:
> > > On 9/4/05, Francois Romieu <romieu@fr.zoreil.com> wrote:
> > > > Bret Towe <magnade@gmail.com> :
> > > > [...]
> > > > > after moving some files on the server to a new location then trying to
> > > > > add the files
> > > > > to xmms playlist i found the following in dmesg after xmms froze
> > > > > wonder how many more items i can find...
> > > >
> > > > The system includes some binary only stuff. Please contact your vendor
> > > > or provide the traces for a configuration wherein the relevant module
> > > > was not loaded after boot. It may make sense to get in touch with
> > > > nfs@lists.sourceforge.net then.
> > >
> > > the 'binary only stuff' is ati-drivers kernel module and it crashs
> > > with or without it
> > > ill provide a 'untainted' trace as soon as i can repeat the bug again
> >
> > ok without ati-drivers kernel module loaded the computer basicly just
> > hard locks when
> > some bug hits dunno if its the same item
> 
> Do you get anything from alt-sysrq-T?

no i havent used that im usally in x when its freezing
x wont even switch to console would it still give me anything then?
 
> > to repeat it tho one needs laptop-mode enabled have xmms playing music
> > (flac in my case)
> > which resides on nfs then just put the computer under some local load
> > for a little bit
> > till which im guessing it needs to clear some memory or somethin and
> > it hits this hard lock
> > or the errors i mailed previously when ati-drivers is loaded
> 
> What kernel version is this?

2.6.13


> --b.
>
