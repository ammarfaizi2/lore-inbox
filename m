Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUCBWbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUCBWbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:31:12 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:1284
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261981AbUCBWbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:31:09 -0500
Date: Tue, 2 Mar 2004 23:31:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: albhaf <albhaf@home.se>, linux-kernel@vger.kernel.org
Subject: Re: Better performance with 2.6
Message-ID: <20040302223148.GU2185@dualathlon.random>
References: <1078229894.53b994c0albhaf@home.se> <4044D513.5090607@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4044D513.5090607@matchmail.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 10:40:19AM -0800, Mike Fedyk wrote:
> albhaf wrote:
> >I know that 2.6 has the ability to get better
> >performance than the other versions.
> >But what parts of the kernel has provided to this
> >performance upgrade?
> 
> Preempt

preempt hurts a bit performance (at least when running a single threaded
app) with the object of helping interactivity, I say in theory because
a 2.4-aa based kernel has a worst case RT scheduler latency lower than
2.6 with preempt enabled (during I/O and some other workload).
