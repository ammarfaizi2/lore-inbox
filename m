Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbTDPIdC (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 04:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTDPIdC 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 04:33:02 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:19841
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S264268AbTDPIdB 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 04:33:01 -0400
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DMA transfers in 2.5.67
References: <yw1x3ckjfs2v.fsf@zaphod.guide>
	<1050438684.28586.8.camel@dhcp22.swansea.linux.org.uk>
	<yw1xy92be915.fsf@zaphod.guide>
	<1050439715.28586.17.camel@dhcp22.swansea.linux.org.uk>
	<yw1xptnne7lv.fsf@zaphod.guide>
	<20030416123654.A2629@jurassic.park.msu.ru>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 16 Apr 2003 10:43:47 +0200
In-Reply-To: <20030416123654.A2629@jurassic.park.msu.ru>
Message-ID: <yw1xk7duessc.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

> On Wed, Apr 16, 2003 at 12:09:00AM +0200, Måns Rullgård wrote:
> > Btw, I just noticed that hard disk throughput is much lower with 2.5
> > than 2.4.  With 2.4.21-pre5 I get ~40 MB/s, but with 2.5.67 the speed
> > drops to 25-30 MB/s.  Everything according to hdparm.  Is it possible
> > that DMA is generally slow for some reason?
> 
> Possible reason is that in 2.4 we've forced reasonable latency timer
> value for all PCI devices, while in 2.5 we haven't as yet.

Do you mean whatever causes this message (for a 3com NIC)?

PCI: Setting latency timer of device 00:05.0 to 64

Would that also explain why my hard disks are slow under 2.5?  There
is no corresponding message for the ide controller (htp374).

-- 
Måns Rullgård
mru@users.sf.net
