Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbUC2Mfs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUC2Mec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:34:32 -0500
Received: from ns.suse.de ([195.135.220.2]:60577 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262870AbUC2MdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:33:08 -0500
Date: Mon, 29 Mar 2004 09:10:25 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, jun.nakajima@intel.com,
       ricklind@us.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       kernel@kolivas.org, rusty@rustcorp.com.au, anton@samba.org,
       lse-tech@lists.sourceforge.net, mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
 sched-2.6.5-rc2-mm2-A3
Message-Id: <20040329091025.6030d127.ak@suse.de>
In-Reply-To: <20040329090301.42dc9f97.ak@suse.de>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>
	<20040325154011.GB30175@wotan.suse.de>
	<20040325190944.GB12383@elte.hu>
	<20040325162121.5942df4f.ak@suse.de>
	<20040325193913.GA14024@elte.hu>
	<20040325203032.GA15663@elte.hu>
	<20040329084531.GB29458@wotan.suse.de>
	<4068066C.507@yahoo.com.au>
	<20040329080150.4b8fd8ef.ak@suse.de>
	<20040329114635.GA30093@elte.hu>
	<20040329090301.42dc9f97.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004 09:03:01 +0200
Andi Kleen <ak@suse.de> wrote:
> 
> I'm trying to, but -mm5 doesn't work at all on the 4 way machine.
> It goes through the full boot up sequence, but then never opens a login
> on the console and sshd also doesn't work.
> 
> Andrew, maybe that's related to your tty fixes?

Reverting the two makes login work again

-Andi
