Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbTI0F4M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 01:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbTI0F4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 01:56:12 -0400
Received: from dialup-19.156.221.203.acc50-nort-cbr.comindico.com.au ([203.221.156.19]:23056
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262377AbTI0F4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 01:56:11 -0400
Message-ID: <3F752619.5000406@cyberone.com.au>
Date: Sat, 27 Sep 2003 15:54:33 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>, len.brown@intel.com
CC: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       adq_dvb@lidskialf.net
Subject: Re: [PATCH] ACPI pci irq routing fix
References: <20030926182128.C24360@osdlab.pdx.osdl.net>
In-Reply-To: <20030926182128.C24360@osdlab.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Wright wrote:

>If irq.active is set from _CRS, make sure to use it, rather than trying
>anything from the from the _PRS list, as some machines don't handle this
>properly.  This patch is against current linux-acpi-test-2.6.0.  It's
>been floating about for a while, and fixes bug #1186.
>
>Patch originally from Andrew de Quincey.
>
>thanks,
>-chris
>

This fixes my bug #1257.


