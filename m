Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVDYPwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVDYPwv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVDYPwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:52:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2483 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262653AbVDYPjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:39:20 -0400
Date: Mon, 25 Apr 2005 17:20:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050425152049.GB2508@elf.ucw.cz>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <20050424213822.GB9304@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424213822.GB9304@mail.shareable.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I believe the point is:
> > > > 
> > > >    1. Person is logged from client Y to server X, and mounts something on
> > > >       $HOME/mnt/private (that's on X).
> > > > 
> > > >    2. On client Y, person does "scp X:mnt/private/secrets.txt ."
> > > >       and wants it to work.
> > > > 
> > > > The second operation is a separate login to the first.
> > > 
> > > Solution?
> > 
> > ... is the same as for the same question with "set of mounts" replaced
> > with "environment variables".
> 
> Not quite.
> 
> After changing environment variables in .profile, you can copy them to
> other shells using ". ~/.profile".
> 
> There is no analogous mechanism to copy namespaces.

Actually, after you add right mount xyzzy /foo lines into .profile,
you can just . ~/.profile ;-).
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
