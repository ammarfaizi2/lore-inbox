Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266562AbUAWOj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 09:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266564AbUAWOj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 09:39:56 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:36521 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266562AbUAWOjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 09:39:54 -0500
Date: Fri, 23 Jan 2004 14:38:06 +0000
From: Dave Jones <davej@redhat.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Evaldo Gardenali <evaldo@gardenali.biz>, linux-kernel@vger.kernel.org
Subject: Re: buggy raid checksumming selection?
Message-ID: <20040123143806.GL9327@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Evaldo Gardenali <evaldo@gardenali.biz>,
	linux-kernel@vger.kernel.org
References: <40112465.8040801@gardenali.biz> <20040123141352.GA19002@redhat.com> <40112E29.4060800@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40112E29.4060800@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 01:22:33AM +1100, Nick Piggin wrote:

 > >> Uhh. correct me if I am wrong, but shouldnt it select the fastest 
 > >algorithm?
 > >
 > >No, if it can choose a function which avoids polluting the cache over
 > >one that doesn't, it will.  Even if that means slightly less raw throughput
 > >
 > >This comes up time after time, maybe we need a printk in that case ?
 > 
 > How about removing the entire output? Is it really needed?

It's probably on a par with http://www.hadess.net/files/stuff/vpenis.c  8-)
You have a point though, it probably is pointless these days.

		Dave

