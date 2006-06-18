Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWFRHTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWFRHTN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWFRHTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:19:12 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45697 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751109AbWFRHTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:19:11 -0400
Date: Sun, 18 Jun 2006 12:48:47 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Sam Vilain <sam@vilain.net>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, Balbir Singh <balbir@in.ibm.com>,
       linux-kernel@vger.kernel.org, maeda.naoaki@jp.fujitsu.com,
       kurosawa@valinux.co.jp
Subject: Re: [RFC] CPU controllers?
Message-ID: <20060618071847.GA4988@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com> <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4494EA66.8030305@vilain.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 05:53:42PM +1200, Sam Vilain wrote:
> Bear in mind that we have on the table at least one group of scheduling 
> solutions (timeslice scaling based ones, such as the VServer one) which 
> is virtually no overhead and could potentially provide the "jumpers" 
> necessary for implementing more complex scheduling policies.

Sam,
	Do you have any plans to post the vserver CPU control
implementation hooked against maybe Resource Groups (for grouping
tasks)? Seeing several different implementation against current
kernel may perhaps help maintainers decide what they like and what they
don't?

-- 
Regards,
vatsa
