Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285585AbRLRFos>; Tue, 18 Dec 2001 00:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285591AbRLRFok>; Tue, 18 Dec 2001 00:44:40 -0500
Received: from nat.transgeek.com ([66.92.79.28]:19187 "HELO smtp.transgeek.com")
	by vger.kernel.org with SMTP id <S285585AbRLRFo3>;
	Tue, 18 Dec 2001 00:44:29 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Craig Christophel <merlin@transgeek.com>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Tue, 18 Dec 2001 00:46:01 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.GSO.4.21.0112172059510.6100-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0112172059510.6100-100000@weyl.math.psu.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011218014358.C1ACBC7382@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 December 2001 21:31, Alexander Viro wrote:
> There is a word for that and that word is "crap".
>
> Let loader leave an archive to be unpacked into rootfs?  Sure.  Let kernel
> exec /init on rootfs and leave the rest to it?  Absolutely.  But let's
> stop adding userland stuff into the kernel. 


I agree 100%.  there are several other popular systems that try to do 
everything in-kernel and it adds to the instability overall, besides it gives 
less freedom to customize with standard tools.



Craig.


 Loading modules _can_ be
> done from userland - insmod does it just fine.  And that's where it should
> be done.
