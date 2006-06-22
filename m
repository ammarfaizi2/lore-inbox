Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030624AbWFVQVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030624AbWFVQVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030640AbWFVQVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:21:43 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:65462 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1030624AbWFVQVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:21:42 -0400
Date: Thu, 22 Jun 2006 18:21:41 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Danial Thom <danial_thom@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Measuring tools - top and interrupts
Message-ID: <20060622162141.GC14682@harddisk-recovery.com>
References: <20060622152621.92347.qmail@web33301.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060622152621.92347.qmail@web33301.mail.mud.yahoo.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 08:26:21AM -0700, Danial Thom wrote:
> Running 2.6.17, it seems that top is reporting
> 100% idle with a network load of about 75K pps
> (bridged) , which seems unlikely. Is it possible
> that system load accounting is turned off by some
> tunning knob?

75K packets/s isn't too hard for modern NICs, especially when using
NAPI.

> Is there something that shows the current
> interrupts/second in LINUX (such as systat in
> 'BSD)?

"vmstat 1£ has the number of interrupts in the "in" column.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
