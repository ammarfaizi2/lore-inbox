Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270553AbUJTW7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270553AbUJTW7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUJTWzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:55:50 -0400
Received: from palrel11.hp.com ([156.153.255.246]:64982 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S270577AbUJTWyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:54:25 -0400
Date: Wed, 20 Oct 2004 15:54:18 -0700
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6 IrDA] Stir driver usb reset fix
Message-ID: <20041020225418.GA26559@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20041020010733.GJ12932@bougret.hpl.hp.com> <20041020155349.4514de82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020155349.4514de82.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 03:53:49PM -0700, Andrew Morton wrote:
> Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:
> >
> > 	o [CORRECT] stir4200 - get rid of reset on speed change
> > The Sigmatel 4200 doesn't accept the address setting which gets done on
> > USB reset.  The USB core recently changed to resend address (or
> > something like that), so usb_reset_device is failing.
> 
> This needs fixups due to competing changes.  Please review:

	Stephen,

	Do you want to take care of that and forward a new patch
directly to Andrew ?
	Thanks...

	Jean
