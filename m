Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUK2IEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUK2IEf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 03:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUK2IEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 03:04:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:45841 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261231AbUK2IEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 03:04:34 -0500
Subject: Re: Question about /dev/mem and /dev/kmem
From: Arjan van de Ven <arjan@infradead.org>
To: Jim Nelson <james4765@verizon.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41AA9E26.4070105@verizon.net>
References: <41AA9E26.4070105@verizon.net>
Content-Type: text/plain
Message-Id: <1101715470.2814.30.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 29 Nov 2004 09:04:30 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-28 at 22:57 -0500, Jim Nelson wrote:
> I was looking at some articles about rootkits on monolithic kernels, and had a 
> thought.  Would a kernel config option to disable write access to /dev/mem and 
> /dev/kmem be a workable idea?

look at the -mm patch series ;-)

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/broken-out/dev-mem-restriction-patch.patch


(fwiw this patch is also in the Fedora Core kernels for quite some time
now)

