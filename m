Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132571AbREICYJ>; Tue, 8 May 2001 22:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132580AbREICX7>; Tue, 8 May 2001 22:23:59 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:61960
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S132571AbREICXr>; Tue, 8 May 2001 22:23:47 -0400
Date: Tue, 08 May 2001 22:22:43 -0400
From: Chris Mason <mason@suse.com>
To: Michael Stiller <michael@ping.de>, linux-kernel@vger.kernel.org
cc: nfs@lists.sourceforge.net
Subject: Re: 2.2.19 + reiserfs 3.5.32 nfsd wait_on_buffer/down_failed
Message-ID: <1164860000.989374963@tiny>
In-Reply-To: <20010508164243.A23213@ping.de>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, May 08, 2001 04:42:43 PM +0200 Michael Stiller <michael@ping.de> wrote:

> Hi,
> 
> we run a nfs server utilizing 2.2.19 + ReiserFS version 3.5.32 on a
> P 3 550 machine. Disk subsystem is a GDT7518RN using 4 UW disks as raid 5
> device. After upgrading from 2.2.17 + reiserfs to 2.2.19 we experience
> many (very much more than with 2.2.17) problems with our nfs clients
> about 12 (linux). Network ist 100Mbit full duplex / switched. 
> I do not think this is network related, cause ping -f doesnt show any
> packet loss. 
> 
> During not so heavy IO on the exported fs
> one nfsd thread seems to be waiting for the disk:

Are you running any patches to make knfsd deal with the reiserfs iget issues?

-chris

