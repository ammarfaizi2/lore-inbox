Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267394AbUG2Anv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267394AbUG2Anv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUG2Akw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:40:52 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:15818 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S266476AbUG2Ajk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:39:40 -0400
From: David Brownell <david-b@pacbell.net>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: fixing usb suspend/resuming
Date: Tue, 20 Jul 2004 22:05:37 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200405281406.10447@zodiac.zodiac.dnsalias.org> <40F962B6.3000501@pacbell.net> <200407190927.38734@zodiac.zodiac.dnsalias.org>
In-Reply-To: <200407190927.38734@zodiac.zodiac.dnsalias.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407202205.37763.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 July 2004 00:27, Alexander Gran wrote:
> Am Samstag, 17. Juli 2004 19:32 schrieb David Brownell:

> > I'm suspecting that something is mistranslating between ACPI
> > power state numbering and PCI power state numbering
> 
> ACK.

See http://bugme.osdl.org/show_bug.cgi?id=2886 ... basically
it looks like this problem would show up with any of a dozen
or so different drivers, few of which are widely used on systems
that use suspend/resume much (laptops!).

- Dave
