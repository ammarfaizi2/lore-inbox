Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUHVPSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUHVPSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267465AbUHVPSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:18:12 -0400
Received: from the-village.bc.nu ([81.2.110.252]:17807 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267415AbUHVPSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:18:07 -0400
Subject: Re: 2.6.8.1-mm2 breaks vmware
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Tonnerre <tonnerre@thundrix.ch>, Ville Herva <vherva@viasys.com>,
       Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       petr@vandrovec.name,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040822135923.GA24092@vana.vc.cvut.cz>
References: <20040820104230.GH23741@viasys.com>
	 <20040820035142.3bcdb1cb.akpm@osdl.org> <20040820131825.GI23741@viasys.com>
	 <20040820144304.GF8307@viasys.com> <20040820151621.GJ23741@viasys.com>
	 <20040820114518.49a65b69.akpm@osdl.org>
	 <20040820184932.GA11789@devserv.devel.redhat.com>
	 <20040820193024.GL23741@viasys.com> <20040822114214.GB19768@thundrix.ch>
	 <20040822135923.GA24092@vana.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093184131.24597.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 15:15:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-22 at 14:59, Petr Vandrovec wrote:
> > Does VMware > 4.0 still require cmov?
> 
> Yes, this requirement is not going to go away: VMware >= 4.0 / GSX >= 3.0 require
> processors which support CMOV instruction.

qemu isnt as fast and isnt as featured but doesn't need cmov. The
current one runs stuff like Win98 rather well including PCI video card
emulation.

Alan

