Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbUC1KHO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 05:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUC1KHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 05:07:14 -0500
Received: from omr3.netsolmail.com ([216.168.230.164]:4503 "EHLO
	omr3.netsolmail.com") by vger.kernel.org with ESMTP id S262240AbUC1KHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 05:07:12 -0500
From: <shai@ftcon.com>
Message-Id: <200403281006.BHM58378@ms6.netsolmail.com>
Reply-To: <shai@ftcon.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <ricklind@us.ibm.com>, <mbligh@aracnet.com>,
       <lse-tech@lists.sourceforge.net>,
       "'Erik Jacobson'" <erikj@subway.americas.sgi.com>,
       "'Erich Focht'" <efocht@hpce.nec.com>, "'Paul Jackson'" <pj@sgi.com>,
       "'Xavier Bru'" <xavier.bru@bull.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [Lse-tech] Re: NUMA scheduler issue
Date: Sun, 28 Mar 2004 02:06:45 -0800
Organization: FT Consulting
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200403260930.59284.efocht@hpce.nec.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcQTD+3nX+TOcKyFTqG7YuYx8aLHxgBm3aAQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Very nice patch.
Andrew, would you consider adding this one? 

--Shai


-----Original Message-----
From: lse-tech-admin@lists.sourceforge.net
[mailto:lse-tech-admin@lists.sourceforge.net] On Behalf Of Erich Focht
Sent: Friday, March 26, 2004 00:31
To: Paul Jackson; Xavier Bru
Cc: ricklind@us.ibm.com; mbligh@aracnet.com; lse-tech@lists.sourceforge.net;
Erik Jacobson
Subject: Re: [Lse-tech] Re: NUMA scheduler issue

Hi Paul,

On Wednesday 24 March 2004 20:03, Paul Jackson wrote:
> Where are you getting the printouts that look like:
>
>     initial CPU = 2
>     cpu  18491 16
>     cpu0 17125 2
>     cpu1 441 0
>     cpu2 700 14
>     cpu3 225 0
>     ...
>     current_cpu 0
>
> We have something in our SGI 2.4 kernels (/proc/<pid>/cpu) that
> displays this sort of per-cpu usage, but I don't see anything
> in the 2.6 kernels that seems to do this.

its probably the attached patch. Sorry, I'm travelling and couldn't
rediff against a current version...





