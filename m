Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVAPQqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVAPQqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 11:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVAPQqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 11:46:52 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:38922 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S262541AbVAPQqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 11:46:50 -0500
Message-ID: <41EABBEB.10702@gentoo.org>
Date: Sun, 16 Jan 2005 19:09:31 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joseph Fannin <jhf@rivenstone.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>,
       William Park <opengeometry@yahoo.ca>, wli@holomorphy.com
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <20050116005930.GA2273@zion.rivenstone.net>
In-Reply-To: <20050116005930.GA2273@zion.rivenstone.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CqDY8-0007UR-Et*28UbI52X.RA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Fannin wrote:
> On Fri, Jan 14, 2005 at 12:23:52AM -0800, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
> 
> 
>>waiting-10s-before-mounting-root-filesystem.patch
>>  retry mounting the root filesystem at boot time
> 
> 
>     With this patch, initrds seem to get 'skipped'.  I think this is
> probably the cause for the reports of problems with RAID too.

This seems likely and is probably also the cause of wli's problems mentioned 
elsewhere in this thread.

I had overlooked the way that initrd's work in that part of the boot sequence. 
Will investigate.

Daniel
