Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129473AbRB0UIw>; Tue, 27 Feb 2001 15:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129814AbRB0UIn>; Tue, 27 Feb 2001 15:08:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37049 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129473AbRB0UIg>;
	Tue, 27 Feb 2001 15:08:36 -0500
Date: Tue, 27 Feb 2001 15:08:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <Pine.GSO.4.21.0102261137540.79-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0102271500110.4105-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 	New version uploaded on ftp.math.psu.edu/pub/viro/namespaces-d-S2.gz

Changes:
	* fixed an idiotic bug in get_filesystem_info() that din't 
unfortunately) show up on UP.
	* nosuid/nodev/noexec work in any combinations (had been b0rken in
previous version).
	* fixed multiple-mount (had been b0rken; --bind worked, but attempt
to mount the device you've already had mounted did bad things).
	* sanity checks for mount --move were missing. Fixed.
	* Assorted cleanups.

Folks, please help with testing.
 							Cheers,
								Al

