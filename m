Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279902AbRK0OrF>; Tue, 27 Nov 2001 09:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279903AbRK0Oq6>; Tue, 27 Nov 2001 09:46:58 -0500
Received: from femail30.sdc1.sfba.home.com ([24.254.60.20]:5624 "EHLO
	femail30.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S279902AbRK0Oqv>; Tue, 27 Nov 2001 09:46:51 -0500
Message-ID: <3C03A702.EBE823C9@ecf.utoronto.ca>
Date: Tue, 27 Nov 2001 09:45:22 -0500
From: Mark Richards <richard@ecf.utoronto.ca>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@idb.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multiplexing filesystem
In-Reply-To: <3C030FB4.C3303BE4@ecf.utoronto.ca> <3C036A83.F23E6EBE@idb.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

>
> Coda already do what you want:
> Files are kept on a server, and copied to your local disk when
> you use it.  You may even disconnect when working on the local
> copy - your changes will be propagated back to the server
> whenever you reconnect to the network.
> The copying is indeed completely transparent.
>
> If you need reservation - use the permission system.
> A suid program simply makes _you_ owner, and only
> the owner gets write permission.  This is your check-out
> program.  Check-in consists of changing ownership
> back to root (or some userid allocated to the versioning system)
>
> Helge Hafting

I'll look into Coda, but ideally I wouldn't have to copy each file to the local
workstation when I use it, only when it is reserved for editing.  Also, I'd like to
be able to store the local copy anywhere on the filesystem, if possible.

Mark

