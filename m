Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbTGCTs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 15:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbTGCTs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 15:48:26 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:57604 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265326AbTGCTsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 15:48:25 -0400
Date: Thu, 3 Jul 2003 22:08:58 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Boszormenyi Zoltan <zboszor@freemail.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030703200858.GA31084@hh.idb.hist.no>
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu> <20030703122243.51a6d581.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703122243.51a6d581.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 12:22:43PM -0700, Andrew Morton wrote:
> Boszormenyi Zoltan <zboszor@freemail.hu> wrote:
> >
> > Hi,
> > 
> > I actually tried it. It seems that although I compiled an SMP kernel, it 
> > does not use both CPUs.
> 
> You're right.  The kernel sort-of saw the second CPU but it appears to have
> not come up.
> 
I may have this problem on my dual celeron.  I noticed X got sluggish
while generating a key for mozilla - very strange on a dual
but I put it down to the scheduler changes.

Looking at dmesg I see that both is detected, and it claims
both are "activated", but I get this a little later:

Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
mtrr: v2.0 (20020519)

I never get a CPU 2 IS NOW UP (or CPU 0)

Helge Hafting
