Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271220AbTHRFTm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 01:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271214AbTHRFTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 01:19:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24809 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271210AbTHRFTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 01:19:40 -0400
Date: Sun, 17 Aug 2003 22:11:55 -0700
From: "David S. Miller" <davem@redhat.com>
To: insecure@mail.od.ua
Cc: arjanv@redhat.com, carlosev@newipnet.com, dhollis@davehollis.com,
       alan@lxorguk.ukuu.org.uk, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030817221155.2013e6a9.davem@redhat.com>
In-Reply-To: <200308172246.12835.insecure@mail.od.ua>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
	<200308171845560303.00D4B163@192.168.128.16>
	<1061140404.29559.0.camel@laptop.fenrus.com>
	<200308172246.12835.insecure@mail.od.ua>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003 22:46:12 +0300
insecure <insecure@mail.od.ua> wrote:

> On Sunday 17 August 2003 20:13, Arjan van de Ven wrote:
> > > 1. hidden patch is not in the main linuk kernel stream.... why?
> >
> > because arpfilter is a more generic way of doing things like this, and
> > that IS in the main linux kernel
> 
> I am interested in that but last time I googled for it,
> neither userspace utils nor any documentation turned up.
> I only see some kernel parts of it.

The bridging netfilter (ie. "ebtables") maintainer has
tools available up on his site.

	http://ebtables.sourceforge.net/
