Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275940AbSIUUn2>; Sat, 21 Sep 2002 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275943AbSIUUn2>; Sat, 21 Sep 2002 16:43:28 -0400
Received: from holomorphy.com ([66.224.33.161]:19086 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S275940AbSIUUn2>;
	Sat, 21 Sep 2002 16:43:28 -0400
Date: Sat, 21 Sep 2002 13:41:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 won't run X?
Message-ID: <20020921204150.GS3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <aebr@win.tue.nl>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	linux-kernel@vger.kernel.org
References: <20020921161702.GA709@iucha.net> <597384533.1032600316@[10.10.2.3]> <20020921185939.GA1771@iucha.net> <20020921202353.GA15661@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020921202353.GA15661@win.tue.nl>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 01:59:39PM -0500, Florin Iucha wrote:
>> X is not locked up, as it eats all the CPU. And 2.5.36 works just fine.

On Sat, Sep 21, 2002 at 10:23:53PM +0200, Andries Brouwer wrote:
> I noticed that the pgrp-related behaviour of some programs changed.
> Some programs hang, some programs loop. The hang occurs when they
> are stopped by SIGTTOU. The infinite loop occurs when they catch SIGTTOU
> (and the same signal is sent immediately again when they leave the
> signal routine).
> Have not yet investigated details.

I'm looking into it.


Thanks,
Bill
