Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTDJWa5 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbTDJWa5 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:30:57 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29347
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264186AbTDJWay (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 18:30:54 -0400
Subject: Re: proc_misc.c bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: davidm@hpl.hp.com
Cc: akpm@zip.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
References: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050011057.12930.134.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Apr 2003 22:44:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 23:02, David Mosberger wrote:
> The workaround below is to allocate 4KB per 8 CPUs.  Not really a
> solution, but the fundamental problem is that /proc/interrupts
> shouldn't use a fixed buffer size in the first place.  I suppose
> another solution would be to use vmalloc() instead.  It all feels like
> bandaids though.

How about switching to Al's seqfile interface ?

