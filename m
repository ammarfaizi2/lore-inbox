Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbTJ1Mko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 07:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbTJ1Mkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 07:40:43 -0500
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:59869
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263957AbTJ1Mkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 07:40:42 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Autoregulate vm swappiness cleanup
Date: Tue, 28 Oct 2003 23:40:37 +1100
User-Agent: KMail/1.5.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200310232337.50538.kernel@kolivas.org> <200310251658.23070.kernel@kolivas.org> <20031028110443.GA1792@elf.ucw.cz>
In-Reply-To: <20031028110443.GA1792@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310282340.38029.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 22:04, Pavel Machek wrote:
> Hi!

Hello!

> I believe swappiness == 100 was "I want max throughput, I don't care
> about latency going through roof", while swappiness == 0 was "I don't
> want you to swap too much, behave reasonably".
>
> As you don't know if user cares about latency or not, I don't see how
> you can autotune this.

Well I guess you either see merit in what my patch does based on what I said, 
or you don't... so I guess you don't. That's fine; I just offered why I felt 
this helped in my varied workloads more than a static value did.

Con

