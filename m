Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbTHTAMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 20:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbTHTAML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 20:12:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56976 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261641AbTHTAKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 20:10:06 -0400
Date: Tue, 19 Aug 2003 17:02:56 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: rmk@arm.linux.org.uk, jonsmirl@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: Standard driver call to enable/disable PCI ROM
Message-Id: <20030819170256.2dfafeea.davem@redhat.com>
In-Reply-To: <20030820000535.GD18035@mail.jlokier.co.uk>
References: <20030819210618.D23670@flint.arm.linux.org.uk>
	<20030819204643.75442.qmail@web14913.mail.yahoo.com>
	<20030819215246.H23670@flint.arm.linux.org.uk>
	<20030819141735.52ffedc7.davem@redhat.com>
	<20030820000535.GD18035@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003 01:05:35 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> David S. Miller wrote:
> > There are many devices which stop responding to MEM and IO
> > space once their ROM is enabled, Qlogic-ISP chips are one
> > such device and there are several others.
> 
> I take it the devices do respond to MEM and IO after the ROM is
> disabled again?

That is correct.
