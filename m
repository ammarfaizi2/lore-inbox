Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTEGXNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTEGXL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:11:56 -0400
Received: from tomts11.bellnexxia.net ([209.226.175.55]:10695 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264362AbTEGXLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:11:36 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Helge Hafting <helgehaf@aitel.hist.no>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Date: Wed, 7 May 2003 19:24:41 -0400
User-Agent: KMail/1.5.9
Cc: wli@holomorphy.com, helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, akpm@digeo.com
References: <3EB8E4CC.8010409@aitel.hist.no> <20030507.064010.42794250.davem@redhat.com> <20030507215430.GA1109@hh.idb.hist.no>
In-Reply-To: <20030507215430.GA1109@hh.idb.hist.no>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305071924.41279.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 7, 2003 05:54 pm, Helge Hafting wrote:
> On Wed, May 07, 2003 at 06:40:10AM -0700, David S. Miller wrote:
> >    From: William Lee Irwin III <wli@holomorphy.com>
> >    Date: Wed, 7 May 2003 07:41:00 -0700
> >
> >    In another thread, you mentioned that a certain netfilter cset had
> >    issues; I think it might be good to add that as a second possible
> >    cause.
> >
> > Good point, Helge what netfilter stuff do you have in use?
> > Are you doing NAT?
>
> I have compiled in almost everything from netfilter, except
> from "Amanda backup protocol support" and "NAT of local connections"
>
> I also have ipv6 compiled, but no ipv6-netfilter.
>
> I don't do any NAT.  I used to have some firewall rules, but not currently
> as some previous dev-kernel broke on that.  So I have iptables
> with no rules, just an ACCEPT policy for everything. I do no
> routing either, only one network card is used.

I just had mm2 lockup here too.  Not sure just what when wrong - my serial
console was not connected.  I should be able to try it again later this evening.

I do not use iptables here, I do use ipchains.

Ed Tomlinson
