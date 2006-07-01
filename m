Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWGALCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWGALCV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 07:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWGALCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 07:02:21 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:20874 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932243AbWGALCU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 07:02:20 -0400
Date: Sat, 1 Jul 2006 12:58:22 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm one process gets stuck in infinite loop in the kernel.
Message-ID: <20060701105822.GA10714@aitel.hist.no>
References: <20060629013643.4b47e8bd.akpm@osdl.org> <44A3B8A0.4070601@aitel.hist.no> <20060629104117.e96df3da.akpm@osdl.org> <20060630215405.GA9744@aitel.hist.no> <20060630165532.5eadf286.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630165532.5eadf286.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 04:55:32PM -0700, Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> 
> Oh.  This is probably the generic_file_buffer_write() hang, due to
> zero-length iovec segments.
> 
> If so, the below should fix it up.

I have not been able to reproduce the problem on mm4, so perhaps
it went away.  Do you want me to test this patch on mm2 anyway?

Helge Hafting
