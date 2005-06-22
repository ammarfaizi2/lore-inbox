Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVFVViv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVFVViv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVFVViu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:38:50 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:15845 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262541AbVFVVeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:34:11 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: 2.6.12 breaks 8139cp
Date: Wed, 22 Jun 2005 15:34:03 -0600
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
References: <42B9D21F.7040908@drzeus.cx>
In-Reply-To: <42B9D21F.7040908@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506221534.03716.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 June 2005 3:03 pm, Pierre Ossman wrote:
> Upgrading from 2.6.11 to 2.6.12 caused my 8139cp network card to stop
> working. No error messages are emitted and everything seems to work
> (from the local computers point of view). But nothing can be recieved
> from the network.

You might post a little more information (i.e., the 2.6.12 dmesg and
possibly a diff vs. 2.6.11).  My guess is something's busted with its
IRQ.
