Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265107AbUGGNPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbUGGNPa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 09:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUGGNPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 09:15:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61316 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265104AbUGGNPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 09:15:16 -0400
Date: Wed, 7 Jul 2004 09:15:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Davide Rossetti <davide.rossetti@roma1.infn.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: MSI to memory?
In-Reply-To: <40EBED33.3050707@roma1.infn.it>
Message-ID: <Pine.LNX.4.53.0407070909250.17962@chaos>
References: <200407011215.59723.bjorn.helgaas@hp.com>
 <20040701115339.A4265@unix-os.sc.intel.com> <40EBED33.3050707@roma1.infn.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, Davide Rossetti wrote:

> Rajesh Shah wrote:
>
> > What type of usage model did you have in mind to have the
> >
> >device write to memory instead of using MSI for interrupts?
> >
> >
> for instance for a fast wake-up trick. the driver loops on a memory
> location until the MSI write access changes the memory content...

Who (another cpu??) writes to memory while your CPU is wasting its
time looping? Maybe MSI stands for Major Service Interruption?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


