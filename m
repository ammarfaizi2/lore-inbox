Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268410AbUHWXe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbUHWXe3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUHWXe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:34:27 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:29071 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S268410AbUHWXdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:33:18 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 23 Aug 2004 16:33:12 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
In-Reply-To: <Pine.LNX.4.58.0408231607450.17766@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408231632280.2428@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
 <20040823233249.09e93b86.ak@suse.de> <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0408231500160.17766@ppc970.osdl.org>
 <Pine.LNX.4.58.0408231552270.3222@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0408231607450.17766@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Linus Torvalds wrote:

> On Mon, 23 Aug 2004, Davide Libenzi wrote:
> > 
> > I think, not sure though (gonna test right now), that the "Segment 
> > Selector Index" part of the error code might be the TSS selector index, 
> > that will enable an even more selective reissue.
> 
> I don't think so. Generally the error code is 0 for all normal GP cases. 
> The error code tends to be non-zero only for the "load segment" things, 
> when it shows what the incorrect segment was.

Indeed, zero is.



- Davide

