Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWFPLXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWFPLXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 07:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWFPLXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 07:23:30 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:61125 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750886AbWFPLX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:23:29 -0400
Date: Fri, 16 Jun 2006 20:25:11 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>
Cc: ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT
 tasks.
Message-Id: <20060616202511.63ece090.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200606161320.34443.ak@suse.de>
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
	<200606161236.50302.ak@suse.de>
	<20060616195807.84fc0b97.kamezawa.hiroyu@jp.fujitsu.com>
	<200606161320.34443.ak@suse.de>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006 13:20:34 +0200
Andi Kleen <ak@suse.de> wrote:

> 
> > Should we send signal (kill or stop) to tasks whose cpus_allowed only contains
> > removed cpu rather than simple migration ?
> 
> At least as a sysctl option it probably makes sense yes.
> 

Thank you for your advise !
I'll retry.

-Kame


