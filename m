Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265987AbUFDUef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUFDUef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUFDUef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:34:35 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62099 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265988AbUFDUec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:34:32 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: David Ford <david+challenge-response@blue-labs.org>
Subject: Re: [boot hang] 2.6.7-rc2, VIA VT8237
Date: Fri, 4 Jun 2004 22:38:04 +0200
User-Agent: KMail/1.5.3
References: <40C0D8FE.7040009@blue-labs.org>
In-Reply-To: <40C0D8FE.7040009@blue-labs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406042238.04100.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 of June 2004 22:18, David Ford wrote:

> This is a brand new mobo w/ an Opteron 148 on it.  SK8V.  The Gentoo
> LiveCD is a 2.6.5 kernel and it boots ok on it.  I'm starting to do
> tests to see what I can do to get it to function.

Can you try booting with "noapic" and/or "acpi=off"?

If it doesn't work, please do binary search to
check what is the last working kernel version.

