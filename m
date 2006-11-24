Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934605AbWKXNqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934605AbWKXNqs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 08:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934606AbWKXNqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 08:46:48 -0500
Received: from bill.weihenstephan.org ([82.135.35.21]:36838 "EHLO
	bill.weihenstephan.org") by vger.kernel.org with ESMTP
	id S934605AbWKXNqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 08:46:48 -0500
From: Juergen Beisert <juergen127@kreuzholzen.de>
Organization: Privat
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 001/001] i386/pci: fix nibble permutation and add Cyrix 5530 IRQ router
Date: Fri, 24 Nov 2006 14:46:43 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200611241144.06267.juergen127@kreuzholzen.de> <200611241409.30546.juergen127@kreuzholzen.de> <20061124133544.5334f789@localhost.localdomain>
In-Reply-To: <20061124133544.5334f789@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611241446.44469.juergen127@kreuzholzen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Friday 24 November 2006 14:35, Alan wrote:
> I have the 5520 data sheet. For IRQ routing the 5520 and 5530 are
> identical according to the docs and code according to the docs doens't
> generally work ..

Yes.

> If you need to set these for LinuxBIOS then perhaps matching and setting
> it up only if LinuxBIOS is present would be the better choice ?

I thought this could improve things, but its ok when I use this patch only for 
my kernel to make it work on my old hardware.

Thanks for your comments.

Juergen
