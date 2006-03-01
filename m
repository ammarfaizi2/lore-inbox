Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWCATQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWCATQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWCATQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:16:59 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43681 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750847AbWCATQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:16:58 -0500
Subject: Re: AMD64 X2 lost ticks on PM timer
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200603011929.59307.ak@suse.de>
References: <200602280022.40769.darkray@ic3man.com>
	 <200603011647.34516.ak@suse.de>
	 <20060301180714.GD20092@ti64.telemetry-investments.com>
	 <200603011929.59307.ak@suse.de>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 14:16:50 -0500
Message-Id: <1141240611.5860.176.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 19:29 +0100, Andi Kleen wrote:
> Sprinkle WARN_ON(in_interrupt()) all over the parts that shouldn't
> have interrupts 
> off. 

Might be faster to just try the -rt kernel, it has tons of debugging
checks for stuff like this.

Lee

