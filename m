Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTF0KCV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 06:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTF0KCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 06:02:21 -0400
Received: from mail.zmailer.org ([62.240.94.4]:20608 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S264147AbTF0KCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 06:02:20 -0400
Date: Fri, 27 Jun 2003 13:16:34 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Alan Cox <alan@redhat.com>
Cc: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: ICH5-SATA file corruption under 2.4.21-ac1
Message-ID: <20030627101634.GQ28900@mea-ext.zmailer.org>
References: <3EFB77CD.1020607@rackable.com> <200306270956.h5R9uH911387@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306270956.h5R9uH911387@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 05:56:17AM -0400, Alan Cox wrote:
> >   On an Intel winterpark motherboard I'm seeing file corruption when 
> > using the onboard SATA interface.  The test I'm running is ctcs's new 
> > kdiff test which just copies a kernel, diffs it, deletes the tree, and 
> > starts over.  (Which seems to find file system issues like this pretty 
> > quickly.) 
> 
> Random bit errors. This really doesn't look like an IDE layer problem
> to be honest. 

What is the distribution of the file offsets where those happen ?
Distributions in terms of   offset modulo 512/1024/2048/4096  ?

If they are always in the beginning of some sort of block, that is
a tell-tale of its own, isn't it ?

/Matti Aarnio
