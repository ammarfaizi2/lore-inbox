Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265045AbUFRL0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUFRL0j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 07:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUFRL0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 07:26:39 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:33671 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265045AbUFRL0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 07:26:38 -0400
Date: Fri, 18 Jun 2004 12:25:49 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: water modem <lundby@ameritech.net>, davej@codemonkey.org.uk,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] undefined reference to `acpi_processor_register_performance
Message-ID: <20040618112549.GF16097@redhat.com>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	water modem <lundby@ameritech.net>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <40D20080.9040909@ameritech.net> <20040617201243.4ebfc9b2.rddunlap@osdl.org> <40D26DD5.60809@ameritech.net> <20040617215812.105c67d0.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617215812.105c67d0.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 09:58:12PM -0700, Randy.Dunlap wrote:
 > 
 > Several CPU_FREQ options need ACPI_PROCESSOR interfaces
 > to build.

Hmm, it should be optional. Ie, if you don't have ACPI enabled,
you should still be able to use these drivers (the k7 one at least),
you just won't be able to use the ACPI fallback.

		Dave

