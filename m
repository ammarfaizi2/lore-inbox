Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVGYObY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVGYObY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 10:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVGYObY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 10:31:24 -0400
Received: from host27-37.discord.birch.net ([65.16.27.37]:7698 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S261240AbVGYObO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 10:31:14 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Timothy Miller'" <theosib@gmail.com>,
       "'Trond Myklebust'" <trond.myklebust@fys.uio.no>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: HELP: NFS mount hangs when attempting to copy file
Date: Mon, 25 Jul 2005 09:34:05 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <9871ee5f05072319523528f2de@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
thread-index: AcWP8jX0Tct7tFw6QCygRlzj32b54ABM1GFA
Message-ID: <EXCHG20036beUzmRf6C0000050f@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 25 Jul 2005 13:29:06.0736 (UTC) FILETIME=[D4ED4B00:01C5911C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A kde and gnome are well above MTU they don't know anything
about MTU and neither does NFS, if those hang it up you have
a network configuration problem, and should probably fix it, 
as a number of other things will show the problem also.

Routers almost always have hard coded MTU limits, and they are
almost never the default 1500, so everything needs to be
properly told what your networks MTU is, or some external
device needs to be taking care of it properly.

                    Roger

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Timothy Miller
> Sent: Saturday, July 23, 2005 9:52 PM
> To: Trond Myklebust
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: HELP: NFS mount hangs when attempting to copy file
> 
> On 7/23/05, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > I beg to disagree. A lot of these VPN solutions are 
> unfriendly to MTU 
> > path discovery over UDP. Sun uses TCP by default when mounting NFS 
> > partitions. Have you tried this on your Linux box?
> 
> I changed the protocol to TCP and changed rsize and wsize to 
> 1024.  I don't know which of those fixed it, but I'm going to 
> leave it for now.
> 
> As for MTU, yeah, the Watchguard box seems to have some 
> hard-coded limits, and for whatever reason KDE and GNOME 
> graphical logins do something that exceeds those limits, 
> completely independent of NFS, and hang up hard.
> 
> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

