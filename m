Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbTDTQNo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 12:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTDTQNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 12:13:44 -0400
Received: from WebDev.iNES.RO ([80.86.100.174]:37249 "EHLO webdev.ines.ro")
	by vger.kernel.org with ESMTP id S263624AbTDTQNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 12:13:43 -0400
Date: Sun, 20 Apr 2003 19:25:43 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.5.68-mm1
In-Reply-To: <20030420161306.GA16656@hh.idb.hist.no>
Message-ID: <Pine.LNX.4.50L0.0304201924490.1931-100000@webdev.ines.ro>
References: <Pine.LNX.4.50L0.0304201843300.1931-200000@webdev.ines.ro>
 <Pine.LNX.4.50L0.0304201850130.1931-100000@webdev.ines.ro>
 <20030420161306.GA16656@hh.idb.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It may be so, but I don't think the kernel should oops...

On Sun, 20 Apr 2003, Helge Hafting wrote:

> On Sun, Apr 20, 2003 at 06:58:33PM +0300, Andrei Ivanov wrote:
> [...]
> > -r--------    1 root     root        48281 Apr 11 21:05 Cats & Dogs (RO).txt
> > -r--------    1 root     root     730341376 Apr 11 21:04 Cats And Dogs.avi
> > 
> > I typed less Cats<tab>, and then &<tab>, and here it was stuck, and the 
> > kernel oopsed. If I type less Cats<tab>, and then \&<tab>, it works, but 
> > without the \ in front of the &, the shell gets stuck in D state.
> 
> Typing 
> <any command> &<TAB>
> gives the shell and the fs some work to do.  The "&" ends one
> command and starts a new one (similiar to ";") so typing
> nothing more after "&" and pressing <TAB> makes the shell search the entire
> path and consider all the commands available.
> (Press tab some more times and see the list, 2078 possibilities
> in my case. :-)  This sort of thing can easily
> take some time (in D state) if your PATH includes network drives.
> 
> Helge Hafting
> 
