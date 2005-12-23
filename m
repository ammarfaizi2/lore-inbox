Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbVLWDjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbVLWDjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 22:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbVLWDjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 22:39:54 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:47843 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030395AbVLWDjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 22:39:53 -0500
Date: Thu, 22 Dec 2005 22:38:54 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Chris Wedgwood <cw@f00f.org>
cc: Diego Calleja <diegocg@gmail.com>, jmerkey@wolfmountaingroup.com,
       mrmacman_g4@mac.com, legal@lists.gnumonks.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       garbageout@sbcglobal.net
Subject: Re: blatant GPL violation of ext2 and reiserfs filesystem drivers
In-Reply-To: <20051223032809.GA31909@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0512222233430.32123@gandalf.stny.rr.com>
References: <43AACF77.9020206@sbcglobal.net> <496FC071-3999-4E23-B1A2-1503DCAB65C0@mac.com>
 <1135283241.12761.19.camel@localhost.localdomain> <43AB32C1.1080101@wolfmountaingroup.com>
 <20051223025638.GA31381@taniwha.stupidest.org> <20051223041522.ac36635d.diegocg@gmail.com>
 <20051223032809.GA31909@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2005, Chris Wedgwood wrote:

> On Fri, Dec 23, 2005 at 04:15:22AM +0100, Diego Calleja wrote:
>
> > So, a GPL application running on top of a BSD-licensed kernel
> > (or library) is illegal? I doubt it...
>
> applications don't link with the kernel, modules do
>
> i don't know if that makes modules legal or not, but it's certainly
> not clear cut
>

The thing here is that the GPL discusses distributing.  If I were to
receive a binary kernel, that happens to have implemented the same API as
Linux, is it a violation of the GPL.  As long as it doesn't use any of the
same code and does a "clean room" kind of implementation of the API it is
perfectly legal.

So now if I have this binary kernel, and I myself compile a GPL module, I
don't see anything in the GPL that would prevent me from linking it in.
This is where it gets to be a problem with binary modules.  They only
implement up to the API (granted, it shouldn't include code in the
headers), but it's the user that's linking and not the distributor.  That
is where the gray area lies.

-- Steve

