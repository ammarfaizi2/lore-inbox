Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUF3URx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUF3URx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUF3UQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:16:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26805 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262329AbUF3UPX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:15:23 -0400
Date: Wed, 30 Jun 2004 13:14:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Debi Janos <debi.janos@freemail.hu>
Cc: jheffner@psc.edu, linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
Message-Id: <20040630131437.20b5b80a.davem@redhat.com>
In-Reply-To: <1088582682.911.7.camel@alderaan.trey.hu>
References: <Pine.NEB.4.33.0406291729500.11034-100000@dexter.psc.edu>
	<1088582682.911.7.camel@alderaan.trey.hu>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004 10:04:52 +0200
Debi Janos <debi.janos@freemail.hu> wrote:

> 2004-06-29, k keltezéssel 23:36-kor John Heffner ezt írta:
> 
> > Sigh.  I ran in to this problem a year or so ago and it was a broken
> > firewall that was mangling the TCP window scale option.  I think the
> > firewall was an OpenBSD machine, and I was told the problem went away with
> > an upgrade.  I'm curious what they're running here.
> > 
> > The boundary 3 is special because it causes SWS avoidance to break.
> > 
> >   -John
> 
> hmm. interesting. my server sits behind an openbsd packet filter... , but the gentoo's machines uses iptables firewall...

Sounds like the firewall at your end is what might be causing the
problems.

