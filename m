Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVAYRUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVAYRUC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVAYRRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:17:06 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:12739 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262028AbVAYRNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:13:51 -0500
Date: Tue, 25 Jan 2005 11:13:15 -0600
From: Robin Holt <holt@sgi.com>
To: Sachithanantham_Saravanan@emc.com
Cc: linux-ia64@vger.kernel.org, yakker@sgi.com, yakker@turbolinux.com,
       yakker@alacritech.com, matt@aparity.com, linux-kernel@vger.kernel.org
Subject: Re: LKCD on 2.6 IA64 Linux Kernel
Message-ID: <20050125171315.GA4951@lnx-holt.americas.sgi.com>
References: <50C05B7AA7D6924FB5E384EF14BC647BCBBD63@inba1mx2.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50C05B7AA7D6924FB5E384EF14BC647BCBBD63@inba1mx2.corp.emc.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 03:16:21PM -0000, Sachithanantham_Saravanan@emc.com wrote:
> Hi all,
> 
> I tried using lkcd on a ia64 machine running on 2.6.5-7.111 SuSe Kernel for
> debugging. I configured the swap device as the dump device and I created
> panics,oops to generate dumps. The dump happens in /var/log/dump on a "lkcd
> save" after a reboot. When I use lcrash to trace the task of the process
> that caused the dump, I get some data misalignment errors as listed below.
> And interestingly this happens only for the trace of the process that
> generated the panic/oops. For all other processes in the dump trace is
> giving me the proper output. Looks like the issue is specific to ia64 as I
> did not encounter any such errors on my i386 machine on the same kernel. 
> Pointers to any patches or what the problem is will be of help to me.

Which version of lcrash are you using?  I think you will need to build the
latest version of lcrash from the oss.sgi.com web page in order to use the
dumps created by the SuSE kernel.  Not sure though.

Robin
