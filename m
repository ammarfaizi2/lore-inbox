Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWIVEAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWIVEAH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 00:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWIVEAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 00:00:07 -0400
Received: from gw.goop.org ([64.81.55.164]:21738 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932260AbWIVEAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 00:00:06 -0400
Message-ID: <45135FC9.3090504@goop.org>
Date: Thu, 21 Sep 2006 21:00:09 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
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
Subject: Re: [PATCH] Linux Kernel Markers 0.7 for 2.6.17 (with type checking!)
References: <20060921232024.GA16155@Krystal> <451331A1.3020601@goop.org> <20060922020119.GA28712@Krystal> <45134539.7070305@goop.org> <20060922023828.GA10291@Krystal>
In-Reply-To: <20060922023828.GA10291@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> From what I see in 2.6.17/2.6.18 makefiles, only -OS and -O2 are generally 
> used by the build system (no -O3) and there is not use of -funroll-loops. I
> guess it must not be so useful in this context.
>   

Putting a marker in an inlined function would have the same effect.

    J
