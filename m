Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbTJOQVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTJOQVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:21:44 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:12193 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263440AbTJOQVn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:21:43 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16269.29716.461117.338214@laputa.namesys.com>
Date: Wed, 15 Oct 2003 20:21:40 +0400
To: root@chaos.analogic.com
Cc: Erik Mouw <erik@harddisk-recovery.com>, Josh Litherland <josh@temp123.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Transparent compression in the FS
In-Reply-To: <Pine.LNX.4.53.0310151150370.7350@chaos>
References: <1066163449.4286.4.camel@Borogove>
	<20031015133305.GF24799@bitwizard.nl>
	<16269.20654.201680.390284@laputa.namesys.com>
	<20031015142738.GG24799@bitwizard.nl>
	<16269.23199.833564.163986@laputa.namesys.com>
	<Pine.LNX.4.53.0310151150370.7350@chaos>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson writes:
 > On Wed, 15 Oct 2003, Nikita Danilov wrote:
 > 
 > > Erik Mouw writes:
 > >  > On Wed, Oct 15, 2003 at 05:50:38PM +0400, Nikita Danilov wrote:
 > >  > > Erik Mouw writes:
 > >  > >  > Nowadays disks are so incredibly cheap, that transparent compression
 > >  > >  > support is not realy worth it anymore (IMHO).
 > >  > >
 > [SNIPPED...]
 > 
 > >  >
 > >  > PS: let me guess: among other things, reiser4 comes with transparent
 > >  >     compression? ;-)
 > >
 > > Yes, it will.
 > >
 > 
 > EeeeeeK!  A single bad sector could prevent an entire database from
 > being uncompressed! You may want to re-think that idea before you
 > commit a lot of time to it.

It could not if block-level compression is used. Which is the only
solution, given random-access to file bodies.

 > 
 > Cheers,
 > Dick Johnson
 > Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
 >             Note 96.31% of all statistics are fiction.
 > 
 > 

Nikita.
