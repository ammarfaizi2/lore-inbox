Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270619AbUJUEZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270619AbUJUEZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 00:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270629AbUJUEZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 00:25:40 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:58786
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S270613AbUJUEYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 00:24:55 -0400
Date: Wed, 20 Oct 2004 21:09:38 -0700
From: "David S. Miller" <davem@davemloft.net>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, shemminger@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6 IrDA] Stir driver usb reset fix
Message-Id: <20041020210938.2a8e38d1.davem@davemloft.net>
In-Reply-To: <20041020225418.GA26559@bougret.hpl.hp.com>
References: <20041020010733.GJ12932@bougret.hpl.hp.com>
	<20041020155349.4514de82.akpm@osdl.org>
	<20041020225418.GA26559@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004 15:54:18 -0700
Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:

> On Wed, Oct 20, 2004 at 03:53:49PM -0700, Andrew Morton wrote:
> > Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:
> > >
> > > 	o [CORRECT] stir4200 - get rid of reset on speed change
> > > The Sigmatel 4200 doesn't accept the address setting which gets done on
> > > USB reset.  The USB core recently changed to resend address (or
> > > something like that), so usb_reset_device is failing.
> > 
> > This needs fixups due to competing changes.  Please review:
> 
> 	Do you want to take care of that and forward a new patch
> directly to Andrew ?

Andrew/Jeff, I can work on the integration of all of Jean's
patches and I can also resolve all the conflicts myself.

Ok?
