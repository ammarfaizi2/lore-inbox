Return-Path: <linux-kernel-owner+w=401wt.eu-S1754981AbWL1U6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981AbWL1U6T (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754982AbWL1U6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:58:19 -0500
Received: from [139.30.44.16] ([139.30.44.16]:15023 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754980AbWL1U6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:58:18 -0500
Date: Thu, 28 Dec 2006 21:58:17 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
In-Reply-To: <20061228124644.4e1ed32b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
 <20061228124644.4e1ed32b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006, Andrew Morton wrote:

> On Thu, 28 Dec 2006 21:27:40 +0100 (CET)
> Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> 
> > After Al Viro (finally) succeeded in removing the sched.h #include in 
> > module.h recently, it makes sense again to remove other superfluous 
> > sched.h includes.
> 
> Why are they "superfluous"?  Because those compilation
> units pick up sched.h indirectly, via other includes?
> 
> If so, is that a thing we want to do?

No, there is nothing at all in these files that needs sched.h. I suppose 
the includes are left over from times when more unrelated macros lived in 
sched.h (fortunately much of that cruft got cleand up already).

Tim
