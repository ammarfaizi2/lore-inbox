Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268057AbTB1SSm>; Fri, 28 Feb 2003 13:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbTB1SSm>; Fri, 28 Feb 2003 13:18:42 -0500
Received: from havoc.daloft.com ([64.213.145.173]:20151 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268057AbTB1SSl>;
	Fri, 28 Feb 2003 13:18:41 -0500
Date: Fri, 28 Feb 2003 13:28:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI request/release generic address
Message-ID: <20030228182857.GA17425@gtf.org>
References: <3E5F8DA5.9050804@acm.org> <20030228163253.GB6351@gtf.org> <3E5FA8EC.7030607@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5FA8EC.7030607@acm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 12:22:36PM -0600, Corey Minyard wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> It an acpi_generic_address structure defined in include/acpi/actbl2.h.
> It's an address that can be in memory, I/O, or PCI configuration space.
> 
> The definition is at http://www.microsoft.com/hwdev/tech/onnow/LF-ACPI.asp

ACPI will need to use the existing kernel-based resource reservation
mechanisms, dependent upon which type of address it is.

	Jeff



