Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWFMO52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWFMO52 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 10:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWFMO52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 10:57:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:46854 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751173AbWFMO52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 10:57:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=MZA0+PDPdaistBJwQe2aLQ1GN7giRRp2xZPNQ/0Kd8CZyx6nN5Guhx+DwjdgYhX0khNFH+0Bj53c3dSlIW7b2RbwCeXkVz0Cs6lrKzev3iX8Q3ufh1Fy3iv5dG3IU93I5xfoEiCb0DfjGq+auBXM3YV7B4Bts7dKmi4yf1lMI+g=
Date: Tue, 13 Jun 2006 11:57:18 -0300
From: Alberto Bertogli <albertito@gmail.com>
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [UML] Problems building and running 2.6.17-rc4 on x86-64
Message-ID: <20060613145718.GB9729@gmail.com>
References: <20060514182541.GA4980@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060514182541.GA4980@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 03:25:41PM -0300, Alberto Bertogli wrote:
> It begins to boot, but panics right after mounting root:
> 
> [42949373.800000] kjournald starting.  Commit interval 5 seconds
> [42949373.800000] EXT3-fs: mounted filesystem with ordered data mode.
> [42949373.800000] VFS: Mounted root (ext3 filesystem) readonly.
> [42949373.800000] Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, errno = 0, status = 2943

I just wanted to report that this went away when trying 2.6.17-rc6 as a
host. It also works fine as a guest (after I patch it with
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc4/patches/jmpbuf
so that it builds).

Besides, the random segfault problems I had with previous guests
versions also seem to be fixed.

Thanks a lot!

		Alberto

