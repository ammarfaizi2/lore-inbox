Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbTILTJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTILTJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:09:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7926 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261862AbTILTJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:09:24 -0400
Date: Fri, 12 Sep 2003 11:58:07 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@sgi.com>, Tim Hockin <thockin@hockin.org>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <223220000.1063393087@flay>
In-Reply-To: <20030912182430.GA1043@sgi.com>
References: <20030911192550.7dfaf08c.ak@suse.de.suse.lists.linux.kernel> <1063308053.4430.37.camel@huykhoi.suse.lists.linux.kernel> <20030912162713.GA4852@sgi.com.suse.lists.linux.kernel> <20030912174807.GA629@sgi.com.suse.lists.linux.kernel> <p73y8wtlwf0.fsf@oldwotan.suse.de> <20030912111148.A15308@hockin.org> <20030912182430.GA1043@sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Also - a perhaps more useful test is a write followed by a read.
> 
> Well, someone else will have to run that test.  On Altix, a read() is
> freakishly expensive, and I'm not really interested in showing everyone
> how bad it is ;)

I find percentile comparisons useful for hiding the embarassement
of occasional hardware realities ;-) (ie what's the speed *ratio*
between the two types of read).

M.

