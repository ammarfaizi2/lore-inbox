Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTH1InZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 04:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTH1InE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 04:43:04 -0400
Received: from us01smtp2.synopsys.com ([198.182.44.80]:36785 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S263852AbTH1IIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 04:08:47 -0400
Date: Thu, 28 Aug 2003 10:08:41 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@zip.com.au, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Futex minor fixes
Message-ID: <20030828080841.GA26338@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	akpm@zip.com.au, mingo@redhat.com, linux-kernel@vger.kernel.org
References: <20030827065016.GA11214@Synopsys.COM> <20030828080404.0B1AD2C89E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828080404.0B1AD2C89E@lists.samba.org>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell, Thu, Aug 28, 2003 02:49:10 +0200:
> In message <20030827065016.GA11214@Synopsys.COM> you write:
> > It set to loop unconditionally, so if the source of wakeup insists on
> > wakeing up the code could result in endless loop, right?
> 
> Yes.  If someone wakes you up, you will wake up.  If someone wakes you
> up an infinite number of times, you will wake up an infinite number of
> times.  cf. waitqueues.
> 

Right. If only we could know what that wakers could be...

