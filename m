Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265421AbTGCWMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265417AbTGCWMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:12:40 -0400
Received: from holomorphy.com ([66.224.33.161]:63427 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265422AbTGCWMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:12:39 -0400
Date: Thu, 3 Jul 2003 15:26:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, Boszormenyi Zoltan <zboszor@freemail.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030703222651.GT26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@osdl.org>,
	Boszormenyi Zoltan <zboszor@freemail.hu>,
	linux-kernel@vger.kernel.org
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu> <20030703122243.51a6d581.akpm@osdl.org> <20030703200858.GA31084@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703200858.GA31084@hh.idb.hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 10:08:58PM +0200, Helge Hafting wrote:
> I may have this problem on my dual celeron.  I noticed X got sluggish
> while generating a key for mozilla - very strange on a dual
> but I put it down to the scheduler changes.
> Looking at dmesg I see that both is detected, and it claims
> both are "activated", but I get this a little later:
> Starting migration thread for cpu 0
> Bringing up 1
> CPU 1 IS NOW UP!
> Starting migration thread for cpu 1
> CPUS done 2
> mtrr: v2.0 (20020519)
> I never get a CPU 2 IS NOW UP (or CPU 0)

Could you #define APIC_DEBUG to 1 in include/asm-i386/apicdef.h and
send me a full bootlog?


-- wli
