Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbUDMEk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbUDMEk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:40:28 -0400
Received: from svr44.ehostpros.com ([66.98.192.92]:60368 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S263291AbUDMEk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:40:27 -0400
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: kernel@cc.iitkgp.ernet.in,
       "kernel@cc.iitkgp.ernet.in" <kernel@cc.iitkgp.ernet.in>,
       linux-kernel@vger.kernel.org
Subject: Re: KGDB problem
Date: Tue, 13 Apr 2004 10:09:35 +0530
User-Agent: KMail/1.5
Cc: kgdb-bugreport@lists.sourceforge.net
References: <1081829314.4021.11.camel@cs-rs-221.cse.iitkgp.ernet.in>
In-Reply-To: <1081829314.4021.11.camel@cs-rs-221.cse.iitkgp.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404131009.35464.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you send the gdb output?

-Amit

On Tuesday 13 Apr 2004 9:38 am, kernel@cc.iitkgp.ernet.in wrote:
> ***********************************************
> This Mail is Certified to be Virus Free.
>
> CIC Network Security Group, IIT Kharagpur
> ***********************************************
>
> I have a problem using kgdb.
>
> My test kernel is 2.4.24 and I am using the kgdb patch
> linux-2.4.23-kgdb-1.9.patch downloaded from kgdb.sourceforge.net.
>
> The problem is that whenever I break at a function [say netif_rx() in a
> net driver interrupt routine] and step into it, the "bt" (backtrace)
> command never shows the entire stack trace - it only shows the current
> function. Moreover, the "up" command does not work. Could anybody tell
> me what could be the problem?
>
> Regards.

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

