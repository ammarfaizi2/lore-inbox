Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWIUVy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWIUVy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWIUVy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:54:26 -0400
Received: from tomts25.bellnexxia.net ([209.226.175.188]:6113 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751627AbWIUVyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:54:25 -0400
Date: Thu, 21 Sep 2006 17:49:14 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe management)
Message-ID: <20060921214914.GA31303@Krystal>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060921214248.GA10097@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 17:48:20 up 29 days, 18:57,  1 user,  load average: 0.34, 0.40, 0.30
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers (compudj@krystal.dyndns.org) wrote:
> * Ingo Molnar (mingo@elte.hu) wrote:
>  
> >   "As an example, LTTng traces the page fault handler, when kprobes just
> >    can't instrument it."
> > 
> > but tracing a raw pagefault at the arch level is a bad idea anyway, we 
> > want to trace __handle_mm_fault(). That way you can avoid having to 
> > modify every architecture's pagefault handler ...
> > 
> 
> Then you lose the ability to trace in-kernel minor page faults.
> 
But I agree with you that an upstream MARKER makes more sense in
__handle_mm_fault(). :-)

Regards,

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
