Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270134AbRIAIQ7>; Sat, 1 Sep 2001 04:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270165AbRIAIQt>; Sat, 1 Sep 2001 04:16:49 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:56334 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S270134AbRIAIQg>;
	Sat, 1 Sep 2001 04:16:36 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why is tulip in its own directory (at least to 2.4.8) ? 
In-Reply-To: Your message of "Fri, 31 Aug 2001 20:37:07 +0100."
             <Pine.LNX.4.21.0108312031320.711-100000@pppg_penguin.linux.bogus> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 01 Sep 2001 18:16:49 +1000
Message-ID: <19669.999332209@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2001 20:37:07 +0100 (BST), 
Ken Moffat <ken@kenmoffat.uklinux.net> wrote:
>I've just changed the NIC on my main box from a natsemi to a tulip. The
>natsemi module was in /lib/modules/`uname -r`/kernel/drivers/net along
>with the ppp modules, but the tulip module is in a tulip subdirectory.

The module install directory tree follows the source tree structure.
All the module tools know about this directory structure.  Do not hard
code pathnames in insmod, just "insmod tulip" and let the tools do
their job.


