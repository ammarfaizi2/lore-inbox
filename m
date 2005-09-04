Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVIDVwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVIDVwW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 17:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVIDVwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 17:52:22 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:12228 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932077AbVIDVwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 17:52:21 -0400
Date: Sun, 4 Sep 2005 17:52:19 -0400
To: Bret Towe <magnade@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs4 client bug
Message-ID: <20050904215219.GA9812@fieldses.org>
References: <dda83e78050903171516948181@mail.gmail.com> <dda83e7805090320053b03615d@mail.gmail.com> <20050904103523.GA5613@electric-eye.fr.zoreil.com> <dda83e78050904124454fc675a@mail.gmail.com> <dda83e78050904135113b95c4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda83e78050904135113b95c4a@mail.gmail.com>
User-Agent: Mutt/1.5.10i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 01:51:08PM -0700, Bret Towe wrote:
> On 9/4/05, Bret Towe <magnade@gmail.com> wrote:
> > On 9/4/05, Francois Romieu <romieu@fr.zoreil.com> wrote:
> > > Bret Towe <magnade@gmail.com> :
> > > [...]
> > > > after moving some files on the server to a new location then trying to
> > > > add the files
> > > > to xmms playlist i found the following in dmesg after xmms froze
> > > > wonder how many more items i can find...
> > >
> > > The system includes some binary only stuff. Please contact your vendor
> > > or provide the traces for a configuration wherein the relevant module
> > > was not loaded after boot. It may make sense to get in touch with
> > > nfs@lists.sourceforge.net then.
> > 
> > the 'binary only stuff' is ati-drivers kernel module and it crashs
> > with or without it
> > ill provide a 'untainted' trace as soon as i can repeat the bug again
> 
> ok without ati-drivers kernel module loaded the computer basicly just
> hard locks when
> some bug hits dunno if its the same item 

Do you get anything from alt-sysrq-T?

> to repeat it tho one needs laptop-mode enabled have xmms playing music
> (flac in my case)
> which resides on nfs then just put the computer under some local load
> for a little bit
> till which im guessing it needs to clear some memory or somethin and
> it hits this hard lock
> or the errors i mailed previously when ati-drivers is loaded

What kernel version is this?

--b.
