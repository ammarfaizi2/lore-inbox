Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWAETE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWAETE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbWAETE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:04:56 -0500
Received: from 200-77-196-210.ctetij.cablered.com.mx ([200.77.196.210]:19329
	"EHLO server.alvarezp.pri") by vger.kernel.org with ESMTP
	id S1751347AbWAETEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:04:55 -0500
Date: Thu, 05 Jan 2006 11:00:41 -0800
From: "Octavio Alvarez" <alvarezp@alvarezp.ods.org>
To: "Dave Jones" <davej@redhat.com>, "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: mm/rmap.c negative page map count BUG.
Cc: "Andrew Morton" <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
References: <20060103082609.GB11738@redhat.com> <43BA630F.1020805@yahoo.com.au> <20060103135312.GB18060@redhat.com> <20060104155326.351a9c01.akpm@osdl.org> <20060105074718.GF20809@redhat.com> <1136448712.2920.4.camel@laptopd505.fenrus.org> <20060105111520.GL20809@redhat.com>
Organization: (None)
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.s2w4pyqm4oyyg1@octavio.tecbc.mx>
In-Reply-To: <20060105111520.GL20809@redhat.com>
User-Agent: Opera M2/8.50 (Win32, build 7700)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2006 03:15:20 -0800, Dave Jones <davej@redhat.com> wrote:

> On Thu, Jan 05, 2006 at 09:11:51AM +0100, Arjan van de Ven wrote:
>  >
>  > > Quite a few Fedora users have hit it over the last year,
>  > > but what I find fascinating is that there's not a single
>  > > occurance of "BUG at mm/rmap.c" in our 2.6.9 based RHEL4 bug  
> reports.
>  >
>  > could mean it's caused by consumer hardware code...
>
> Yeah. People buying enterprise distros do tend to buy branded RAM
> with goodies like ECC from big name suppliers instead of a cheap $20
> noname DIMM from "Joe's computers".
>
> So it *could* be a lot of these are crappy hardware, especially
> as some of the reports do indicate that the problem went away
> when they upgraded their RAM.  Some of the others though, I'm
> not so sure.

Nevertheless, there are more instances of the bug in recent versions.
For me, version 2.6.10 or 2.6.11 seems to be the big difference, from
1 bug monthly to --suddenly-- 4 weekly.

I'm experiecing that problem too. I have notice that sometimes
"bad_page_state" trigger before the BUG is reported.

http://lkml.org/lkml/2005/12/14/449

I have already installed the instrumentation Dave provided. I'll see how
it goes.

