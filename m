Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbTIDRCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTIDRCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:02:08 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:43997 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S265152AbTIDRCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:02:06 -0400
From: Daniel Phillips <phillips@arcor.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Date: Thu, 4 Sep 2003 19:05:46 +0200
User-Agent: KMail/1.5.3
References: <20030903180547.GD5769@work.bitmover.com> <20030904013253.GB4306@holomorphy.com> <7420000.1062642672@[10.10.2.4]>
In-Reply-To: <7420000.1062642672@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309041905.46756.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 04:31, Martin J. Bligh wrote:
> I view UP -> SMP -> NUMA -> SSI on NUMA -> SSI on many PCs -> beowulf
> cluster as a continuum ...

Nicely put.  But the last step, ->beowulf, doesn't fit with the others, 
because all the other steps are successive levels of virtualization that try 
to preserve the appearance of a single system, whereas Beowulf drops the 
pretence and lets applications worry about the boundaries, i.e., it lacks 
essential SSI features.  Also, the hardware changes on each of the first four 
arrows and stays the same on the last one.

Regards,

Daniel

