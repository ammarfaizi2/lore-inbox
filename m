Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267190AbUGMWiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbUGMWiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267192AbUGMWgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:36:18 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:49870 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267189AbUGMWgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:36:04 -0400
Date: Tue, 13 Jul 2004 15:35:41 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ricky Beam <jfbeam@bluetronic.net>,
       "Eric D. Mudama" <edmudama@bounceswoosh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org
Subject: Re: SATA disk device naming ?
Message-ID: <20040713223541.GB7980@taniwha.stupidest.org>
References: <20040713064645.GA1660@bounceswoosh.org> <Pine.GSO.4.33.0407131221000.25702-100000@sweetums.bluetronic.net> <20040713164911.GA947@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713164911.GA947@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 12:49:11PM -0400, Jeff Garzik wrote:

> For LABEL to work on root filesystem, you need an initrd.

initrd is such a PITA at times, I wondered about something hacky like
sticking LABEL parsing for rootfs (marked init) into the kernel but
it's really gross.

Ideally the initrd/initramfs process just needs better (userspace)
infrastructure to make it more reliable/easier.



  --cw
