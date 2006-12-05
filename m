Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936850AbWLEWhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936850AbWLEWhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936859AbWLEWhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:37:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39346 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936850AbWLEWhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:37:45 -0500
Date: Tue, 5 Dec 2006 22:28:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: William Cohen <wcohen@redhat.com>
Cc: eranian@hpl.hp.com, perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       oprofile-list@lists.sourceforge.net,
       perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [perfmon] 2.6.19 new perfmon code base + libpfm + pfmon
Message-ID: <20061205222810.GA6385@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Cohen <wcohen@redhat.com>, eranian@hpl.hp.com,
	perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
	oprofile-list@lists.sourceforge.net,
	perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20061204164644.GO31914@frankl.hpl.hp.com> <4575AB54.2050509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4575AB54.2050509@redhat.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 12:24:36PM -0500, William Cohen wrote:
> Some of the ptrace functions (e.g. ptrace_may_attach in perfmon_syscall.c) 
> being used in the perfmon kernel patches will go away with the utrace 
> patches: http://people.redhat.com/roland/utrace/

At least for ptrace_may_attach that's not true in the lastest version
from Roland - in fact it's the last unconditional function in ptrace.c
in that version.  I suggested to him to rename and move it in my review,
though.

