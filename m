Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbTGLFEJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 01:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbTGLFEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 01:04:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54456 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S267614AbTGLFEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 01:04:07 -0400
Date: Fri, 11 Jul 2003 22:09:05 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@intercode.com.au>
Cc: jkenisto@us.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       akpm@osdl.org, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk,
       rddunlap@osdl.org, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH - RFC] [1/2] 2.6 must-fix list - kernel error reporting
Message-Id: <20030711220905.2ea9ebc5.davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0307120135120.21806-100000@excalibur.intercode.com.au>
References: <3F0DB9A5.23723BE1@us.ibm.com>
	<Mutt.LNX.4.44.0307120135120.21806-100000@excalibur.intercode.com.au>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003 01:37:44 +1000 (EST)
James Morris <jmorris@intercode.com.au> wrote:

> On Thu, 10 Jul 2003, Jim Keniston wrote:
> 
> > That begs the question: do we trust that nobody but the kernel will send
> > packets to a NETLINK_KERROR socket?  Ordinary users can't, but any root
> > application can.  Without kerror_netlink_rcv(), such packets don't get
> > dequeued.
> 
> Indeed, the kernel socket buffer fills up.
> 
> I think this needs to be addressed in the netlink code, per the patch 
> below.

Looks good, I'll apply this.
