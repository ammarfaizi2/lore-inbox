Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWISQki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWISQki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWISQki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:40:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030210AbWISQkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:40:37 -0400
Date: Tue, 19 Sep 2006 09:39:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-Id: <20060919093935.4ddcefc3.akpm@osdl.org>
In-Reply-To: <4510151B.5070304@google.com>
References: <20060918234502.GA197@Krystal>
	<20060919081124.GA30394@elte.hu>
	<451008AC.6030006@google.com>
	<20060919154612.GU3951@redhat.com>
	<4510151B.5070304@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006 09:04:43 -0700
Martin Bligh <mbligh@google.com> wrote:

> It seems like all we'd need to do
> is "list all references to function, freeze kernel, update all
> references, continue"

"overwrite first 5 bytes of old function with `jmp new_function'".
