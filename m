Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUDAGuW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 01:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUDAGuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 01:50:22 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:56795 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262750AbUDAGuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 01:50:15 -0500
Date: Thu, 1 Apr 2004 08:50:13 +0200
From: bert hubert <ahu@ds9a.nl>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] multiple namespaces
Message-ID: <20040401065013.GA16648@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1080800087.1490.14.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080800087.1490.14.camel@cube>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 01:14:47AM -0500, Albert Cahalan wrote:

> root 0 ~# PS1='\D:\w> '
> C:~> subst D: /mnt/cdrom
> C:~> D
> D:~> ls -og
> total 38292
> -rw-r--r--    1  2557952 Apr  1  2004 ADrives-Abort_Retry_Fail.mp3

Very good, now I can do away with mdir and friends, I've been longing to
just type 'A' again and know that I'm on my trusty floppy drive.

Perhaps I'll whip up something that monitors /dev/log and can return the
sanity of Abort/Retry/Ignore to Linux. This should be integrated with bash
but as your namespace patches need some work in that area too, that should
not be a problem.

Thanks Albert!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
