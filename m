Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263820AbUGHL6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUGHL6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 07:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbUGHL6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 07:58:52 -0400
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:53399 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S263820AbUGHL6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 07:58:51 -0400
Date: Thu, 8 Jul 2004 13:58:50 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Willy Weisz <weisz@vcpc.univie.ac.at>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kaya <kaya@emailkaya.com>
Subject: Re: APIC error on CPU0:60(60)
Message-ID: <20040708115849.GA32540@boogie.lpds.sztaki.hu>
References: <40EBFAF7.1080505@vcpc.univie.ac.at> <200407071914.44496.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407071914.44496.mbuesch@freenet.de>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 07:14:41PM +0200, Michael Buesch wrote:

> I can't say if the reason is not a faulty CPU. Maybe,
> maybe not. Who knows.

Well, I have a machine which produces "APIC error" messages only if the
kernel has been configured with CONFIG_PCI_USE_VECTOR enabled. Without
CONFIG_PCI_USE_VECTOR, I get no APIC errors. The machine has a single
1.7GHz P4 in it, and the kernel has ACPI, APIC and IO-APIC support all
enabled. I can provide more detailed information if needed but it will
take some time since the machine is not connected to any network.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
