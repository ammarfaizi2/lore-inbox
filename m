Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUBREEu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbUBREEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:04:50 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:2466 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262126AbUBREEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:04:40 -0500
Date: Wed, 18 Feb 2004 04:01:30 +0000
From: Dave Jones <davej@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Santiago Leon <santil@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH][2.6] IBM PowerPC Virtual Ethernet Driver
Message-ID: <20040218040130.GC26304@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Santiago Leon <santil@us.ibm.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>
References: <40329A24.5070209@us.ibm.com> <1077065118.1082.83.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077065118.1082.83.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 11:45:20AM +1100, Benjamin Herrenschmidt wrote:

 > BITFIELDS ARE EVIL !!!
 > 
 > Especially when mapping things like HW registers... I know the p/iSeries
 > code is full of them, I'd strongly recommend getting rid of them.
 > 
 > The compiler is perfectly free, afaik, to re-order them

That can't be right surely ? That would make them utterly useless afaics.
I've not seen this happen in practice either with the 2 x86 cpufreq drivers
I wrote that both use bitfields extensively.

		Dave

