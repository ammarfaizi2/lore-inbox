Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTIPNJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTIPNJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:09:32 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:22534 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261891AbTIPNJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:09:31 -0400
Date: Tue, 16 Sep 2003 10:11:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>, <neilb@cse.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
In-Reply-To: <20030916102113.0f00d7e9.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Sep 2003, Stephan von Krawczynski wrote:

> Sep 16 03:03:09 brenda last message repeated 2 times
> Sep 16 03:03:09 brenda kernel: nfs: server 192.168.1.1 OK 
> Sep 16 03:03:10 brenda last message repeated 2 times
> 
> And then the nfs-action is dead. Process hangs. This has not happened with
> 2.4.22 as a server. It showed up after a day of creating 4,7 GB dvd iso images.
> Creating theses isos was ok, no error or so during the action.
> Is it possible that pre4 does not recover all that well from former memory
> pressure?
>  
> > Have you tried 2.4.22-aa?
> 
> Sorry, not yet.
> I will go back to 2.4.22 and stress it to see if these effects show up.

Oh... Jens just pointed bounce buffering is needed for the upper 2Gs. 

Maybe you have a SCSI card+disks to test ? 8)

