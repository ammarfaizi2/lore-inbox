Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTDGWXd (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263706AbTDGWXd (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:23:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55724 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263183AbTDGWXc convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 18:23:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: More Testing with 4000 disks
Date: Mon, 7 Apr 2003 14:32:08 -0800
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200304071454.49849.pbadari@us.ibm.com> <20030407141551.5900e44f.akpm@digeo.com>
In-Reply-To: <20030407141551.5900e44f.akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304071532.08472.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 April 2003 02:15 pm, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > Hi,
> >
> > Here is more on testing with simulated 4000 disks.
> >
> > I mounted 4000 simulated (scsi_debug) disks. But
> > when I tried to do IO on 200 of them (just reads),
> > system is 100% busy. Here are the vmstat,
> > 10-sec profile output and sysrq-t output.
> >
> > I am wondering why 100% sys ?
>
> This doesn't make sense.  You're showing 50% CPU time in schedule(), yet
> the (undescribed) machine is doing only 11k context switches/sec.

Machine is:
8x 900MHz P-III
4GB RAM

>
> How come?
>
> What context switch rate and profile were you getting when performing IO
> against a large number of real disks?

I have only 50 real disks. I can get info on these.

Thanks,
Badari

