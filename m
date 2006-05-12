Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWELGST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWELGST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWELGST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:18:19 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:11935 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750939AbWELGST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:18:19 -0400
Date: Fri, 12 May 2006 02:18:03 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Clark Williams <williams@redhat.com>
cc: Robert Crocombe <rwcrocombe@raytheon.com>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.16-rtXYZ hangs at boot on quad Opteron
In-Reply-To: <44634F63.1090504@redhat.com>
Message-ID: <Pine.LNX.4.58.0605120216001.26721@gandalf.stny.rr.com>
References: <44623EE0.8040300@raytheon.com> <Pine.LNX.4.58.0605101540490.22959@gandalf.stny.rr.com>
 <44628A70.1020502@raytheon.com> <44634F63.1090504@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 May 2006, Clark Williams wrote:

> Robert Crocombe wrote:
> > testing NMI watchdog ... OK.
> >
> > where we croak.  On the non-realtime version, it is instead like so:
>
> Yeah, this is where my Athlon64x2 goes into the weeds.  I followed it
> down into the routines that calculate processor migration costs and
> got lost in the context switches.  I suspect that the forced
> migrations aggravate a problem down in the 64-bit arch specific code
> that hasn't been looked at in a while (I believe most people running
> AMD are doing so in 32-bit mode).
>
> Maybe it's time for round two...
>

Hmm, I run my AMDx2 in 64bit kernel mode and 32bit user space.  But since
it is my main machine I don't usually test the new -rt kernels on it that
often.  Looks like when I'm back in the States, I'll have to test it
again.

-- Steve

