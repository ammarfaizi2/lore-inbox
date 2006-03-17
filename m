Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWCQEOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWCQEOE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWCQEOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:14:03 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28859 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751238AbWCQEOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:14:02 -0500
Subject: Re: nfs udp 1000/100baseT issue
From: Lee Revell <rlrevell@joe-job.com>
To: Neil Brown <neilb@suse.de>
Cc: Bret Towe <magnade@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <17434.12285.88843.708858@cse.unsw.edu.au>
References: <dda83e780603151424u1b3ea605vd6e8dea896fc276e@mail.gmail.com>
	 <Pine.LNX.4.61.0603162139450.11776@yvahk01.tjqt.qr>
	 <dda83e780603161733o10a3c330kddf96a726f162fa7@mail.gmail.com>
	 <17434.7434.626268.71114@cse.unsw.edu.au>
	 <dda83e780603161911o7c2babb7wfc6671f9bc3441e4@mail.gmail.com>
	 <17434.12285.88843.708858@cse.unsw.edu.au>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 23:13:54 -0500
Message-Id: <1142568835.25258.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 14:41 +1100, Neil Brown wrote:
> 
> > >
> > >   - use tcp
> > 
> > im wondering why this isnt the default to begin with
> 
> Because it wasn't that many years ago that Linux NFS didn't support
> tcp at all.
> Some distributions modify 'mount' to get it to prefer tcp over udp. 

Also historical reasons that predate Linux, the original NFS
implementations were UDP only.  TCP was not an option until NFSv3.

Lee

