Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbTBOS0A>; Sat, 15 Feb 2003 13:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbTBOS0A>; Sat, 15 Feb 2003 13:26:00 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:58122 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264818AbTBOS0A>; Sat, 15 Feb 2003 13:26:00 -0500
Date: Sat, 15 Feb 2003 18:35:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.61
Message-ID: <20030215183555.A22045@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Feb 14, 2003 at 05:11:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   o use per-cpu data for ia32 profiler

any reason you only changed prof_counter to pr-cpu data and not the
two NR_CPUS arrays above it?

>   o acpi: Split i386 support up

Shouldn't this be in arch/i386/acpi/ instead of arch/i386/kernel/acpi/

