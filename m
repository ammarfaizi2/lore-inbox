Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUEXRny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUEXRny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 13:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbUEXRnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 13:43:53 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:18918 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264419AbUEXRnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 13:43:31 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
References: <20040522013636.61efef73.akpm@osdl.org>
	<m165aorm70.fsf@ebiederm.dsl.xmission.com>
	<20040522180837.3d3cc8a9.akpm@osdl.org> <527jv4ymd4.fsf@topspin.com>
	<20040524161733.GX5414@waste.org>
	<m17jv1n4fk.fsf@ebiederm.dsl.xmission.com>
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: 24 May 2004 10:43:30 -0700
In-Reply-To: <m17jv1n4fk.fsf@ebiederm.dsl.xmission.com>
Message-ID: <52brkdwwjh.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 May 2004 17:43:30.0207 (UTC) FILETIME=[A046E2F0:01C441B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Eric> If no hardware actually cared or someone could show me that
    Eric> you can't generate a 64bit memory I/O cycle on the PCI bus
    Eric> that would be interesting.  I have seen several drivers that
    Eric> care.  Later today I intend to look at my pci docs and
    Eric> confirm that 64bit I/O cycles do exist on the bus, even in
    Eric> 32bit slots.  PCI bus traffic is packet based so I would be
    Eric> strongly surprised if 64bit cycles did not exist.

Hang on -- how could you generate a 64-bit cycle on a 32-bit PCI bus?
By definition a 32-bit PCI bus can only transfer 32 bits per cycle.

PCI Express traffic is packet based but parallel PCI definitely is not.

 - Roland

