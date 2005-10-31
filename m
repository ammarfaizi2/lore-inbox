Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVJaDi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVJaDi3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVJaDi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:38:29 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:55367 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751304AbVJaDi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:38:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=E60fTCoFBNLXBgO8/Evcy35UBO/I17a8eeXt9idb4cDX2PzTqUIVfbpNKRG/cdw79hNTDPuzIfsJXN16LOpGpgzRXC1hz27DhFOUPrKqFb44prBuGPeGVOnPGYaUE0W3teRtKhNSXh/zYDSw6EcTEib+er8DKEcRp5noXMWSs1s=
Message-ID: <436591A5.20609@gmail.com>
Date: Mon, 31 Oct 2005 14:38:13 +1100
From: Grant Coady <gcoady@gmail.com>
Organization: http://bugsplatter.mine.nu/
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci_ids: remove non-referenced symbols from pci_ids.h
References: <200510290000.j9T00Bqd001135@hera.kernel.org> <20051031024217.GA25709@redhat.com>
In-Reply-To: <20051031024217.GA25709@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Oct 28, 2005 at 05:00:11PM -0700, Linux Kernel wrote:
>  > tree 68609a74c3bc43e510f58f9c808a0a74e9d23452
>  > parent 4153812fc10ea91cb1a7b6ea4f4337dd211c1ef7
>  > author Grant Coady <gcoady@gmail.com> Thu, 29 Sep 2005 11:06:40 +1000
>  > committer Greg Kroah-Hartman <gregkh@suse.de> Sat, 29 Oct 2005 05:36:59 -0700
>  > 
>  > [PATCH] pci_ids: remove non-referenced symbols from pci_ids.h
>  > 
>  > pci_ids.h cleanup: removed non-referenced symbols, compile tested
>  > with 'make allmodconfig'
>  > 
>  > Signed-off-by: Grant Coady <gcoady@gmail.com>
>  > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> This patch is removing some PCI idents from drivers that are currently
> marked BROKEN on some/all architectures.  It seems counterproductive
> to create even more work to get those drivers fixed.

Nobody cares, the drivers are dying of bit-rot :)

> Especially in the case of for eg, the advansys scsi driver, which
> actually works for some people, even though it isn't updated to use
> modern scsi layer interfaces.

Any positive suggestions?  How many years does a driver remain
broken before it gets removed?  These drivers don't compile cleanly
thus are not in use, no?  Perhaps a set of patches scheduling
removal is in order.

Grant.
