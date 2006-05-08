Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWEHRE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWEHRE1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWEHRE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:04:27 -0400
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:47286 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S932448AbWEHRE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:04:26 -0400
Date: Mon, 8 May 2006 19:04:24 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Erik Mouw <erik@harddisk-recovery.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Message-ID: <20060508170424.GM22958@boogie.lpds.sztaki.hu>
References: <200605051010.19725.jasons@pioneer-pra.com> <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org> <1147100149.2888.37.camel@laptopd505.fenrus.org> <20060508152255.GF1875@harddisk-recovery.com> <1147102290.2888.41.camel@laptopd505.fenrus.org> <20060508154217.GH1875@harddisk-recovery.com> <20060508164705.GC19040@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508164705.GC19040@flint.arm.linux.org.uk>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 05:47:05PM +0100, Russell King wrote:

> Seems to me that somethings wrong somewhere.  Either that or the first
> load average number no longer represents the load over the past one
> minute.

... or just the load average statistics and the CPU usage statistics are
computed using different algorithms and they thus estimate different
things. At least the sampling frequency is surely different.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
