Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUJRSVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUJRSVW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbUJRSUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:20:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:52175 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267341AbUJRSQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:16:56 -0400
Date: Mon, 18 Oct 2004 20:16:54 +0200
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: bevand_m@epita.fr, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: NMI watchdog detected lockup
Message-Id: <20041018201654.58905384.ak@suse.de>
In-Reply-To: <41740430.30604@osdl.org>
References: <4172F91D.8090109@osdl.org>
	<ckv123$pcs$1@sea.gmane.org>
	<4173F9A7.2090504@osdl.org>
	<20041018200017.0098710d.ak@suse.de>
	<41740430.30604@osdl.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 10:58:08 -0700
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

> > Something on your system creates bogus NMI interrupts. What chipset
> > are you using exactly?
> > 
> > Sometimes chipsets can be programmed to raise NMIs when an PCI bus
> > error occurs. 
> > 
> > 21 is the normal state (PIT timer running, but no errors logged) 
> > 
> > If you have an AMD 8131 it could be in theory erratum 54, but then
> > normally one of the error bits in reason should be set.
> 
> Yes, it's an AMD-8111 / 8131 / 8151 / K8-northbridge machine.

It's probably one of your IO cards. I would remove them one by one
or possibly switch them to different slots (PCI vs PCI-X) 

-Andi
