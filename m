Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbULCK7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbULCK7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 05:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbULCK7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 05:59:18 -0500
Received: from gate.corvil.net ([213.94.219.177]:32017 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S262152AbULCK7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 05:59:05 -0500
Message-ID: <41B046BA.1030703@draigBrady.com>
Date: Fri, 03 Dec 2004 10:58:02 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, ganesh.venkatesan@intel.com
CC: Lukas Hejtmanek <xhejtman@mail.muni.cz>, zaphodb@zaphods.net,
       marcelo.tosatti@cyclades.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
References: <20041109203348.GD8414@logos.cnet>	<20041110212818.GC25410@mail.muni.cz>	<20041110181148.GA12867@logos.cnet>	<20041111214435.GB29112@mail.muni.cz>	<4194A7F9.5080503@cyberone.com.au>	<20041113144743.GL20754@zaphods.net>	<20041116093311.GD11482@logos.cnet>	<20041116170527.GA3525@mail.muni.cz>	<20041121014350.GJ4999@zaphods.net>	<20041121024226.GK4999@zaphods.net>	<20041202195422.GA20771@mail.muni.cz> <20041202122546.59ff814f.akpm@osdl.org>
In-Reply-To: <20041202122546.59ff814f.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> 
>>I found out that 2.6.6-bk4 kernel is OK. 
> 
> 
> That kernel didn't have the TSO thing.  Pretty much all of these reports
> have been against e1000_alloc_rx_buffers() since the TSO changes went in.

This possibly related patch went into 2.6 and it bugged me
as Ganesh didn't address the reservations mentioned in the thread:
http://oss.sgi.com/projects/netdev/archive/2004-07/msg00704.html

Pa'draig.
