Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbTBYFfF>; Tue, 25 Feb 2003 00:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTBYFfF>; Tue, 25 Feb 2003 00:35:05 -0500
Received: from brynhild.mtroyal.ab.ca ([142.109.10.24]:26819 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S267612AbTBYFfE>; Tue, 25 Feb 2003 00:35:04 -0500
Date: Mon, 24 Feb 2003 22:45:18 -0700 (MST)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Mike Sullivan <mike.sullivan@alltec.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling with HyperThreading
In-Reply-To: <3E5AC10B.6010705@alltec.com>
Message-ID: <Pine.LNX.4.51.0302242240400.20688@skuld.mtroyal.ab.ca>
References: <3E5AC10B.6010705@alltec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, Mike Sullivan wrote:

> What kernel versions will attempt to distribute jobs across physical CPUs on
> Xeon SMP configurations.

>From what I've heard, Arjans' user space daemon might be the way
things are going, it's at http://people.redhat.com/arjanv/irqbalance/ .

The other way that you might try is the irq load balance patch that Ingo
produced.  There is a patch that is from 2.4.20 at
http://www.hardrock.org/kernel/2.4.20/ and it is what I'm using at work on
our current Xeon systems (until I have the chance to test the user space
daemon at least).

Hope that helps.

Regards
James Bourne

>                         Mike

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

"There are only 10 types of people in this world: those who
understand binary and those who don't."

