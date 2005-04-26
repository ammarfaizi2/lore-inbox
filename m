Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVDZJ3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVDZJ3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVDZJ3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:29:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38807 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261427AbVDZJ3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:29:44 -0400
Date: Tue, 26 Apr 2005 11:29:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426092924.GA4175@elf.ucw.cz>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <20050424213822.GB9304@mail.shareable.org> <20050425152049.GB2508@elf.ucw.cz> <20050425190734.GB28294@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425190734.GB28294@mail.shareable.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > ... is the same as for the same question with "set of mounts" replaced
> > > > with "environment variables".
> > > 
> > > Not quite.
> > > 
> > > After changing environment variables in .profile, you can copy them to
> > > other shells using ". ~/.profile".
> > > 
> > > There is no analogous mechanism to copy namespaces.
> > 
> > Actually, after you add right mount xyzzy /foo lines into .profile,
> > you can just . ~/.profile ;-).
> 
> Is there a mount command that can do that?  We're talking about
> private mounts - invisible to other namespaces, which includes the
> other shells.
> 
> If there was a /proc/NNN/namespace, that would do the trick :)

Sounds like the solution, then. I do not think Al Viro is going to
kill you for /proc/NNN/namespace...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
