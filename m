Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVFMMFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVFMMFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVFMMFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:05:41 -0400
Received: from imap.mtholyoke.edu ([138.110.1.185]:21690 "EHLO
	mist.mtholyoke.edu") by vger.kernel.org with ESMTP id S261522AbVFMMFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:05:30 -0400
From: Ron Peterson <rpeterso@mtholyoke.edu>
Date: Mon, 13 Jun 2005 08:05:20 -0400
To: 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: slow directory listing
Message-ID: <20050613120520.GA26921@mtholyoke.edu>
References: <4dSQ6-1vz-27@gated-at.bofh.it> <4dTCx-2d8-21@gated-at.bofh.it> <E1DgrkL-00029X-HW@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DgrkL-00029X-HW@be1.7eggert.dyndns.org>
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.9i
X-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 12:12:52AM +0200, Bodo Eggert wrote:
> Ron Peterson <rpeterso@mtholyoke.edu> wrote:
> > On Fri, Jun 10, 2005 at 10:37:20AM -0400, rpeterso wrote:
> 
> >> I'm setting up a new mail server, and am testing/tweaking IO.  I have
> >> two directories: /test/a which contains 750 mbox files totalling 8GB,
> >> and /test/a2, which contains the exact same number of files, same names,
> >> all zero length.
> >> ...
> >> The times taken to do a directory listing are significantly different.
> > 
> > I've become more confused, if that's possible.  I was just editing some
> > test script in emacs.  As part of the script creation process I used the
> > M-! command to pipe the output of 'ls /test/a' into a buffer.  It
> > snapped back almost instantly.
> 
> Try ls|cat and take a look at $LS_OPTIONS and $LS_COLORS. I suspect your
> ls tries to use some magic on the files to determine the color.

ls was aliased to 'ls -F', it just took me a while to notice...

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://www.mtholyoke.edu/~rpeterso
