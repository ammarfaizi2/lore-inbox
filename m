Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265575AbTIDV3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbTIDV3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:29:44 -0400
Received: from holomorphy.com ([66.224.33.161]:64145 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265575AbTIDV3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:29:42 -0400
Date: Thu, 4 Sep 2003 14:30:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030904213043.GH4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <25950000.1062601832@[10.10.2.4]> <Pine.LNX.4.44.0309041634250.14715-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309041634250.14715-100000@chimarrao.boston.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 04:36:56PM -0400, Rik van Riel wrote:
> You'll end up with half your accesses being 15 times as
> slow, meaning that your average memory access time is 8
> times as high!  Good way to REDUCE performance, but most
> people won't like that...
> If the NUMA factor is low enough that applications can
> treat it like SMP, then the kernel NUMA support won't
> have to be very high either...

This does not hold. The data set is not necessarily where the
communication occurs.


-- wli
