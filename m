Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946137AbWJ0DaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946137AbWJ0DaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 23:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946139AbWJ0D37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 23:29:59 -0400
Received: from mx1.cs.washington.edu ([128.208.5.52]:49309 "EHLO
	mx1.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1946137AbWJ0D37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 23:29:59 -0400
Date: Thu, 26 Oct 2006 20:29:54 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: Martin Tostrup Setek <martitse@student.matnat.uio.no>
cc: nagar@watson.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: 2.6.18.1] delayacct: cpu_count in taskstats updated
 correctly
In-Reply-To: <Pine.LNX.4.63.0610270440500.21448@honbori.ifi.uio.no>
Message-ID: <Pine.LNX.4.64N.0610262027350.12347@attu2.cs.washington.edu>
References: <Pine.LNX.4.63.0610270440500.21448@honbori.ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006, Martin Tostrup Setek wrote:

> from: Martin T. Setek <martitse@ifi.uio.no>
> 
> cpu_count in struct taskstats should be the same as the corresponding (third)
> value found in /proc/<pid>/schedstat

I disagree in favor of Documentation/accounting/taskstats-struct.txt.
cpu_count is the number of delay values recorded, so accumulating them is 
appropriate.

		David
