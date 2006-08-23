Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWHWRYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWHWRYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 13:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWHWRYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 13:24:05 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:15562 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932324AbWHWRYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 13:24:02 -0400
Date: Wed, 23 Aug 2006 19:24:02 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Al Boldi <a1426z@gawab.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] VFS: FS CoW using redirection
Message-ID: <20060823172402.GC15851@wohnheim.fh-wedel.de>
References: <200607082041.54489.a1426z@gawab.com> <a4e6962a0607081132u4558473cgf89b8b25fcea317d@mail.gmail.com> <200607091550.36407.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200607091550.36407.a1426z@gawab.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 July 2006 15:50:36 +0300, Al Boldi wrote:
> 
> Consider something simple like this:
> 
> VFS - anyFS1 (r/w) used normally, unless ENotFound, then redirect read to
>     \              anyFS2, or CoW from anyFS2 to anyFS1.
>       anyFS2 (r/o) used normally.

That concept is known as union mount.  Jan Blunck did some patches in
that direction, you might be able to find them in the archives.  If
not, just send him a mail.

Jörn

-- 
...one more straw can't possibly matter...
-- Kirby Bakken
