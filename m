Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbWH2Rkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbWH2Rkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWH2Rkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:40:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22683 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965181AbWH2Rkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:40:51 -0400
Date: Tue, 29 Aug 2006 10:40:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
Message-Id: <20060829104017.875733e5.akpm@osdl.org>
In-Reply-To: <200608291256.54665.ak@suse.de>
References: <44F395DE.10804@yahoo.com.au>
	<1156750249.3034.155.camel@laptopd505.fenrus.org>
	<11861.1156845927@warthog.cambridge.redhat.com>
	<200608291256.54665.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 12:56:54 +0200
Andi Kleen <ak@suse.de> wrote:

> While I'm sure it's an interesting intellectual exercise to do these
> advanced rwsems it would be better for everybody else to go for a single 
> maintainable C implementation.

metoo.  It's irritating having multiple implementations around, never being
sure which version people are running with.
