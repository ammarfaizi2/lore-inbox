Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUF2Vxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUF2Vxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbUF2Vxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:53:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21439 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266096AbUF2Vxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:53:47 -0400
Date: Tue, 29 Jun 2004 14:53:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: John Heffner <jheffner@psc.edu>
Cc: shemminger@osdl.org, debi.janos@freemail.hu, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
Message-Id: <20040629145311.1734e2e6.davem@redhat.com>
In-Reply-To: <Pine.NEB.4.33.0406291729500.11034-100000@dexter.psc.edu>
References: <20040629140242.1e274ffb@dell_ss3.pdx.osdl.net>
	<Pine.NEB.4.33.0406291729500.11034-100000@dexter.psc.edu>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004 17:36:45 -0400 (EDT)
John Heffner <jheffner@psc.edu> wrote:

> Sigh.  I ran in to this problem a year or so ago and it was a broken
> firewall that was mangling the TCP window scale option.  I think the
> firewall was an OpenBSD machine, and I was told the problem went away with
> an upgrade.  I'm curious what they're running here.
> 
> The boundary 3 is special because it causes SWS avoidance to break.

Interesting data-point, thanks John.

Can someone go figure out what packages.gentoo.org is using
as a firewall/router?
