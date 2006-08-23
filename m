Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWHWSF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWHWSF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 14:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWHWSF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 14:05:57 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44487 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932448AbWHWSF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 14:05:56 -0400
Date: Wed, 23 Aug 2006 14:05:52 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Al Boldi <a1426z@gawab.com>, Eric Van Hensbergen <ericvh@gmail.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] VFS: FS CoW using redirection
Message-ID: <20060823180552.GC28873@filer.fsl.cs.sunysb.edu>
References: <200607082041.54489.a1426z@gawab.com> <a4e6962a0607081132u4558473cgf89b8b25fcea317d@mail.gmail.com> <200607091550.36407.a1426z@gawab.com> <20060823172402.GC15851@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060823172402.GC15851@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 07:24:02PM +0200, Jörn Engel wrote:
> On Sun, 9 July 2006 15:50:36 +0300, Al Boldi wrote:
> > 
> > Consider something simple like this:
> > 
> > VFS - anyFS1 (r/w) used normally, unless ENotFound, then redirect read to
> >     \              anyFS2, or CoW from anyFS2 to anyFS1.
> >       anyFS2 (r/o) used normally.
> 
> That concept is known as union mount.  Jan Blunck did some patches in
> that direction, you might be able to find them in the archives.  If
> not, just send him a mail.

Or you can give Unionfs a try: http://www.unionfs.org

Josef "Jeff" Sipek.

-- 
The box said "Windows XP or better required". So I installed Linux.
