Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269111AbUIHTuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269111AbUIHTuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269084AbUIHTuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:50:13 -0400
Received: from smtp.terra.es ([213.4.129.129]:40097 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S268686AbUIHTuA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:50:00 -0400
Date: Wed, 8 Sep 2004 21:50:08 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Rik van Riel <riel@redhat.com>
Cc: mbligh@aracnet.com, raybry@sgi.com, marcelo.tosatti@cyclades.com,
       kernel@kolivas.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, piggin@cyberone.com.au
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-Id: <20040908215008.10a56e2b.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.44.0409081403500.23362-100000@chimarrao.boston.redhat.com>
References: <5860000.1094664673@flay>
	<Pine.LNX.4.44.0409081403500.23362-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 08 Sep 2004 14:04:31 -0400 (EDT) Rik van Riel <riel@redhat.com> escribió:

> On Wed, 8 Sep 2004, Martin J. Bligh wrote:
> 
> > For HPC, maybe. For a fileserver, it might be far too little. That's the
> > trouble ... it's all dependant on the workload. Personally, I'd prefer
> > to get rid of manual tweakables (which are a pain in the ass in the field
> > anyway), and try to have the kernel react to what the customer is doing.
> 
> Agreed.  Many of these things should be self-tunable pretty
> easily, too...

I know this has been discussed before, but could a userspace daemon which
autotunes the tweakables do a better job wrt. to adapting the kernel
behaviour depending on the workload? Just like these days we have
irqbalance instead of a in-kernel "irq balancer". It's a alternative
worth of look at?
