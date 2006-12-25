Return-Path: <linux-kernel-owner+w=401wt.eu-S1754361AbWLYJaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbWLYJaG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 04:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754363AbWLYJaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 04:30:06 -0500
Received: from fgwmail9.fujitsu.co.jp ([192.51.44.39]:36399 "EHLO
	fgwmail9.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbWLYJaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 04:30:04 -0500
X-Greylist: delayed 1470 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Dec 2006 04:30:04 EST
Message-ID: <458F940F.5010909@jp.fujitsu.com>
Date: Mon, 25 Dec 2006 18:04:15 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] Update Documentation/pci.txt v7
References: <456404E2.1060102@jp.fujitsu.com> <20061122182804.GE378@colo.lackof.org> <45663EE8.1080708@jp.fujitsu.com> <20061124051217.GB8202@colo.lackof.org> <20061206072651.GG17199@kroah.com> <20061210072508.GA12272@colo.lackof.org> <20061215170207.GB15058@kroah.com> <20061218071133.GA1738@colo.lackof.org> <20061224060726.GC24131@colo.lackof.org> <20061225080635.GB32499@colo.lackof.org>
In-Reply-To: <20061225080635.GB32499@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Sat, Dec 23, 2006 at 11:07:26PM -0700, Grant Grundler wrote:
>> "final" patch v7 and commit log entry appended below. :)
> 
> v8 adds 2cd round of feedback from Randy Dunlap.
> Going once...twice... ;)
> 
>> Full pci.txt text is easier to review at:
>>     http://www.parisc-linux.org/~grundler/Documentation/
> 
> Same place.
> 
> grant
> 
> 
> Rewrite Documentation/pci.txt:
> o restructure document to match how API is used when writing init code.
> o update to reflect changes in struct pci_driver function pointers.
> o removed language on "new style vs old style" device discovery.
>   "Old style" is now deprecated. Don't use it. Left description in
>   to document existing driver behaviors.
> o add section "Legacy I/O Port free driver" by Kenji Kaneshige
>   http://lkml.org/lkml/2006/11/22/25
>   (renamed to "pci_enable_device_bars() and Legacy I/O Port space")

Thank you for updating this.
It looks much better.

Thank you again,
Kenji Kaneshige


