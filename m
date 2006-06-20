Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWFTQ1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWFTQ1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWFTQ1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:27:03 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:15583 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751395AbWFTQ1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:27:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [Cbe-oss-dev] [patch 01/20] cell: add RAS support
Date: Tue, 20 Jun 2006 18:26:53 +0200
User-Agent: KMail/1.9.1
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <20060619183315.653672000@klappe.arndb.de> <20060619183404.144740000@klappe.arndb.de> <20060620154304.GD4845@pb15.lixom.net>
In-Reply-To: <20060620154304.GD4845@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606201826.54290.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 17:43, Olof Johansson wrote:
> 
> > This is a first version of support for the Cell BE "Reliability,
> > Availability and Serviceability" features.
> 
> Does it really make sense to do this under a config option? I don't see
> why anyone would not want to know that their machine is about to melt.
> 
You can only have that when running on bare metal. Machines that run
on a hypervisor can't run that code.

It probably makes sense to auto-select that option for CONFIG_CELL_BLADE
though.

	Arnd <><
