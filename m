Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVBQUtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVBQUtj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVBQUtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:49:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:17118 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262071AbVBQUtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:49:22 -0500
Date: Thu, 17 Feb 2005 12:49:16 -0800
From: cliff white <cliffw@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.6.10-ac12 + kernbench ==  oom-killer: (OSDL)
Message-ID: <20050217124916.7ed6cbe3@es175>
In-Reply-To: <20050209121206.GB13614@logos.cnet>
References: <20050208145707.1ebbd468@es175>
	<20050209121206.GB13614@logos.cnet>
Organization: OSDL
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005 10:12:06 -0200
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> On Tue, Feb 08, 2005 at 02:57:07PM -0800, cliff white wrote:
> > 
> > Running 2.6.10-ac10 on the STP 1-CPU machines, we don't seem to be able to complete
> > a kernbench run without hitting the OOM-killer. ( kernbench is multiple kernel compiles,
> > of course ) Machine is 800 mhz PIII with 1GB memory. We reduce memory for some of the runs.
> 
> Cliff, 
> 
> Please try recent v2.6.11-rc3, they include a series of OOM killer fixes from Andrea et all.
> 

Sorry for the delay in response. Recent -bk runs still show this problem, for example:
http://khack.osdl.org/stp/300713/logs/TestRunFailed.console.log.txt
( patch-2.6.11-rc3-bk4 ) 

cliffw

> Thanks.
> 


-- 
"Ive always gone through periods where I bolt upright at four in the morning; 
now at least theres a reason." -Michael Feldman
