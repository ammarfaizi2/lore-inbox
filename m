Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTKYFfM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 00:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTKYFfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 00:35:12 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:48581 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261973AbTKYFfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 00:35:07 -0500
Date: Tue, 25 Nov 2003 00:33:47 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: OOps! was: 2.6.0-test9-mm5
In-Reply-To: <20031125051018.GA1331@mis-mike-wstn.matchmail.com>
Message-ID: <Pine.LNX.4.58.0311250033170.4230@montezuma.fsmlabs.com>
References: <20031121121116.61db0160.akpm@osdl.org>
 <20031124225527.GB1343@mis-mike-wstn.matchmail.com>
 <Pine.LNX.4.58.0311241840380.8180@montezuma.fsmlabs.com>
 <20031124235807.GA1586@mis-mike-wstn.matchmail.com>
 <20031125003658.GA1342@mis-mike-wstn.matchmail.com>
 <Pine.LNX.4.58.0311242013270.1859@montezuma.fsmlabs.com>
 <20031125051018.GA1331@mis-mike-wstn.matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Mike Fedyk wrote:

> Here you go.  All numbers are right justified, so what's not there starts
> with zeros.
>
> gpf f000 #1
> preempt smp
> cpu: 0
> eip: 0098:[<000052fu>] not tainted VLI
> eflags: 10046
> eip is at 0f52f1
> eax: 8000f000 ebx: 09004 ecx: a0000b edx: fce
> esi: c1f5a31a edi: 0 ebp: c1f5be7c esp: c1f5be4a
> ds: a0  es: a8 ss: 68
> process: swapper (pid: 1 threadinfo-clf5a00 task=clf5aa80
> stack: cfe  dcf00a0 b00b af6easb5 aefd9cb3 0c810001 0 7b0001
>        9c66007b a000 beec0082 bc1f5 20090 2 100a8 a0
>        6750000 600023 20000 0 0 7b0000 7b0000 a00000000
>
> Call trace:

Indeed it looks PnPBIOS related, i'll await your other tests.

Ta,
	Zwane

