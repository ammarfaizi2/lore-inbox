Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWH2QUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWH2QUe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWH2QUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:20:34 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:60545 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S965056AbWH2QUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:20:33 -0400
Date: Tue, 29 Aug 2006 17:20:55 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
Message-ID: <20060829162055.GA31159@linux-mips.org>
References: <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 08:56:36AM -0700, Christoph Lameter wrote:

> > Because i386 (and x86_64) can do better by using XADDL/XADDQ.
> 
> And Ia64 would like to use fetchadd....
> 
> > CMPXCHG is not available on all archs, and may not be implemented on all archs
> > through other atomic instructions.
> 
> Which arches do not support cmpxchg?

MIPS, Alpha - probably any pure RISC load/store architecture.

  Ralf
