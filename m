Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752035AbWISUSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbWISUSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbWISUSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:18:05 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:27027 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1752016AbWISUSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:18:02 -0400
Date: Tue, 19 Sep 2006 16:12:52 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: "S. P. Prasanna" <prasanna@in.ibm.com>
Cc: Martin Bligh <mbligh@google.com>, Vara Prasad <prasadav@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
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
Message-ID: <20060919201252.GD9459@Krystal>
References: <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <4510413F.2030200@us.ibm.com> <45104468.50106@google.com> <20060919093056.GA21618@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060919093056.GA21618@in.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:12:20 up 27 days, 17:21,  6 users,  load average: 0.15, 0.20, 0.33
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* S. P. Prasanna (prasanna@in.ibm.com) wrote:
> 
> Some more coplicated method.
> How about inserting a (instruction size) number of breakpoints and
> wait untill all the threads gets scheduled atleast once (so that
> threads would hit the breakpoint, if their IPs are in the middle of
> instruction we want to replace with jump) and then replace with
> jump instruction.
> 

What happen if a thread is stopped ?

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
