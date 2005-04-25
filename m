Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbVDYTKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVDYTKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVDYTJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:09:12 -0400
Received: from mail.shareable.org ([81.29.64.88]:42920 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262747AbVDYTHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:07:42 -0400
Date: Mon, 25 Apr 2005 20:07:34 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050425190734.GB28294@mail.shareable.org>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <20050424213822.GB9304@mail.shareable.org> <20050425152049.GB2508@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425152049.GB2508@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > > ... is the same as for the same question with "set of mounts" replaced
> > > with "environment variables".
> > 
> > Not quite.
> > 
> > After changing environment variables in .profile, you can copy them to
> > other shells using ". ~/.profile".
> > 
> > There is no analogous mechanism to copy namespaces.
> 
> Actually, after you add right mount xyzzy /foo lines into .profile,
> you can just . ~/.profile ;-).

Is there a mount command that can do that?  We're talking about
private mounts - invisible to other namespaces, which includes the
other shells.

If there was a /proc/NNN/namespace, that would do the trick :)

-- Jamie
