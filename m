Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbTIQNlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 09:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbTIQNlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 09:41:51 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:42151 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262755AbTIQNlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 09:41:50 -0400
Subject: Re: Rik's list of CS challenges
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1063792350.2853.73.camel@pc-16.office.scali.no>
References: <Pine.LNX.4.44.0309101540270.27932-100000@chimarrao.boston.redhat.com>
	 <1063792350.2853.73.camel@pc-16.office.scali.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063806002.12270.31.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Wed, 17 Sep 2003 14:40:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-17 at 10:52, Terje Eggestad wrote:
> What become more interesting is that while you may have NV RAM, it's not
> likely that MRAM is viable on the processor chip. The manufacture
> process may be too expensive, or outright impossible, (polymers on chips
> that hold 80 degrees C in not likely), leaving you with volatile
> register and cache but NV Main RAM. 

We effectively handle that case now with the suspend-to-ram feature.

> A merge of FS and RAM? (didn't the AS/400 have mmap'ed disks?)

Persistant storage systems. These tend to look very unlike Linux because
they throw out the idea of a file system as such. The issues with
debugging if they break and backups make my head hurt but other folk
seem to think they are solved problems
