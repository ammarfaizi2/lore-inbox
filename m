Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbUK3QdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbUK3QdP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUK3Qb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:31:27 -0500
Received: from europa.pnl.gov ([130.20.248.195]:48338 "EHLO europa.pnl.gov")
	by vger.kernel.org with ESMTP id S262187AbUK3Qai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:30:38 -0500
Date: Tue, 30 Nov 2004 08:28:23 -0800
From: Kevin Fox <Kevin.Fox@pnl.gov>
Subject: Re: file as a directory
In-reply-to: <1101804850.17807.16.camel@pear.st-and.ac.uk>
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
Message-id: <1101832103.2885.4.camel@zathras.emsl.pnl.gov>
MIME-version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200411292120.iATLKZxE004233@laptop11.inf.utfsm.cl>
 <41ABA9D3.7020602@st-andrews.ac.uk>
 <1101771315.1261.4.camel@zathras.emsl.pnl.gov>
 <1101804850.17807.16.camel@pear.st-and.ac.uk>
X-OriginalArrivalTime: 30 Nov 2004 16:29:12.0328 (UTC)
 FILETIME=[B9A90880:01C4D6F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 08:54 +0000, Peter Foldiak wrote:
> On Mon, 2004-11-29 at 23:35, Kevin Fox wrote:
> > Heh. So, you can have a filename that can contain XPath looking junk.
> > Now, what happens when you have an XML file that points to another XML
> > file using XPath? How do you separate the file name XPath from the XML
> > XPath?
> 
> My suggestion was simply about unifying the namespace for selection in
> the file system and selection within XML files using a syntax related to
> (but not necessarily identical with) XPath.

So long as its different enough that you can have current XPath
implementations be able to separate the XPath from the filename, it
should be fine.

Really simple example,
file#foo

Is #foo handled by XPath, or passed to the file system?

>  I was not suggesting you should do anything special with the content of
> the XML files, even if the XML file contains an XPath reference.
> (The latter could be interesting to think about as a separate issue
> later, but it is certainly not part of my simpler suggestion.)
>  Peter
> 

What I was suggesting is that if your not careful, it may not be
possible for current libraries to know the difference between its XPath
like stuff and whatever is done in the file system.

Kevin
