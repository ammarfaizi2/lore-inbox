Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270228AbTG2Kz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271240AbTG2Kz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:55:56 -0400
Received: from dialpool-210-214-91-87.maa.sify.net ([210.214.91.87]:48259 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270228AbTG2Kzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:55:55 -0400
Date: Tue, 29 Jul 2003 16:27:06 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 NFS file transfer
Message-ID: <20030729105706.GA2761@localhost.localdomain>
References: <20030728225947.GA1694@localhost.localdomain> <20030729014822.6488539d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729014822.6488539d.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 01:48:22AM -0700, Andrew Morton wrote:
> Balram Adlakha <b_adlakha@softhome.net> wrote:
> >
> > I cannot transfer files larger than 914 mb from an NFS mounted
> > filesystem to a local filesystem. A larger file than that is
> > simply cut of at 914 MB. This is using 2.6.0-test1, 2.4.20 
> > works fine. Can it be the version of mount I'm using? Its the
> > one that comes with util-linux-2.11y.
> 
> Works OK here, with `cp'.  How are you "transferring" the file?
> 
> You're sure there is sufficient disk space on the receiving end? (sorry)
> 
> Can you strace the copy operation, see why it terminates?

Very strange, It was a 4.9 GB raw mpeg-ps file and I couldn't copy more than 914 mb of it using -test2, even playing the file from the server using mplayer didn't work (and I wasn't smart enough to use strace) then I rebooted with 2.4.20 and the whole file was copied. Now I tried copying a 990 mb wav file and it worked(using -test2). The orginal 4.9 GB file is not on the server now so I'll have to put it there first and then copy it again. It'll take some time on my slow NIC (and the server being a 300 Mhz laptop). I'll email you again, sorry.
And yes I have enough disk space on my system :>
