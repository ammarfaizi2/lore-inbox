Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265904AbUBCHG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 02:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265906AbUBCHG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 02:06:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:63634 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265904AbUBCHG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 02:06:27 -0500
Date: Mon, 2 Feb 2004 23:07:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
Cc: linux-kernel@vger.kernel.org, philip@codematters.co.uk
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
Message-Id: <20040202230745.237dd5b6.akpm@osdl.org>
In-Reply-To: <87smhsy7n4.wl@canopus.ns.zel.ru>
References: <87smhsy7n4.wl@canopus.ns.zel.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff <deepfire@sic-elvis.zel.ru> wrote:
>
> 
> > > The machine is a dual P3 450MHz, 512MB, aic7xxx, 2 disk RAID-0 and                   
> > >  ReiserFS.  It's a few years old and has always run Linux, most                      
> > >  recently 2.4.24.  I decided to try 2.6.1 and the performance is                     
> > >  disappointing.                                                                      
> >                                                                                        
> > 2.6 has a few performance problems under heavy pageout at present.  Nick               
> > Piggin has some patches which largely fix it up.                                       
> 
> I`m sorry, but this is misguiding. 2.6 does not have a few performance
> problems under heavy pageout.
> 

As you have frequently and somewhat redundantly reminded us.

Perhaps you could test Nick's patches.   They are at

	http://www.kerneltrap.org/~npiggin/vm/

Against 2.6.2-rc2-mm2.  First revert vm-rss-limit-enforcement.patch, then
apply those three.

