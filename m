Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVBAJAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVBAJAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 04:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVBAJAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 04:00:21 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:53129 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261879AbVBAI7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:59:17 -0500
Date: Tue, 1 Feb 2005 09:59:10 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Helge Hafting <helge.hafting@hist.no>
cc: Michael Buesch <mbuesch@freenet.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] "biological parent" pid
In-Reply-To: <41FF45DA.80404@hist.no>
Message-ID: <Pine.LNX.4.53.0502010957150.23883@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.53.0501311923440.18039@gockel.physik3.uni-rostock.de>
 <200501312309.57464.mbuesch@freenet.de> <Pine.LNX.4.53.0502010035480.19436@gockel.physik3.uni-rostock.de>
 <41FF45DA.80404@hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005, Helge Hafting wrote:

> Tim Schmielau wrote:
> 
> >
> >I'm trying to reconstruct the complete history of processes from the 
> >BSD accounting records. However, this is not very useful if a large 
> >fraction of the processes look as if they were started by init.
> >
> >The following program will print the history in a form vaguely resembling
> >pstree output from the accounting file:
> >  
> >
> Just having those original ppids won't really help you, if the process
> is long gone with no trace of what it was.  Consider adding logging to
> "fork()" and "exec()" instead of doing this. Then you can reconstruct
> history all the way back to the correct executables. 

Why should the process get lost with no trace of what it was - are you 
questioning reliability of BSD accounting?
