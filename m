Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292639AbSCILCX>; Sat, 9 Mar 2002 06:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292643AbSCILCD>; Sat, 9 Mar 2002 06:02:03 -0500
Received: from fungus.teststation.com ([212.32.186.211]:35597 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S292639AbSCILCB>; Sat, 9 Mar 2002 06:02:01 -0500
Date: Sat, 9 Mar 2002 12:01:46 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: <linux-kernel@vger.kernel.org>, Guillaume Boissiere <boissiere@attbi.com>
Subject: Re: LFS support for smbfs in 2.5, and other improvements
In-Reply-To: <20020309005423.GB896@matchmail.com>
Message-ID: <Pine.LNX.4.33.0203091109140.21120-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Mike Fedyk wrote:

> Hi,
> 
> I noticed that LFS support has made it into 2.5, but it's not on the status
> list (http://kernelnewbies.org/status/latest.html).
> 
> IIRC there were some plans to add oplock support to smbfs (newbie alert:
> linux smb client, oplocks are already in samba server).  Maybe that should
> be tracked on the status too.

Using the terminology from the status page I guess this could be the smbfs
list:

Alpha		smbfs: I/O rewrite, smbiod
Alpha		smbfs: Fcntl locking + smb oplock support
Alpha		smbfs: smbconnect for better fstab integration
Planning	smbfs: Readahead support (async readpage/writepage)
Planning	smbfs: Read/Write request merging

But won't the list become very long if every little driver included all
the planned changes? Not my problem I guess ...

Also I don't know if any of this will be ready to be merged within the 6
month limit mentioned in one of the early announcements.


Regarding the updated statuspage, it isn't the "Samba filesystem", it is
the SMB filesystem (usually smbfs, SMBFS, SMBfs and possibly other
variations).

/Urban

