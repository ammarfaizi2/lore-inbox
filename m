Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264240AbTIIQeD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTIIQeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:34:03 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:36227 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264240AbTIIQeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:34:00 -0400
Date: Tue, 9 Sep 2003 09:33:47 -0700
From: Keith Lofstrom <keithl@kl-ic.com>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: keithl@ieee.org, linux-kernel@vger.kernel.org
Subject: Re: Hot Swapping IDE using USB2 cage
Message-ID: <20030909163347.GA2882@gate.kl-ic.com>
Reply-To: keithl@ieee.org
References: <20030908193207.GA29053@gate.kl-ic.com> <200309091601.01731.m.watts@eris.qinetiq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309091601.01731.m.watts@eris.qinetiq.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Sep 09, 2003 at 04:01:01PM +0100, Mark Watts wrote:
> This isn't IDE hotswap, its USB hotswap with USB Mass-Storage devices.

Taxinomically, from a kernel-centric viewpoint, you are correct.

However, from the point of view of users (remember them?) it is
an LBA48 ATA6 IDE device in a bare removable cage that is getting
loaded and unloaded, while the system is running. The fact that,
inside the server case, there are two extra interfaces and an
always-connected USB2 cable is really not that important. That
is why I called it "functional" IDE hotswap. 

True, the bandwidth is lower, it is a distasteful kludge, and
it is more expensive than a hypothetical, purely IDE solution. 
However, a pure solution is not now available, and the pursuit
of that may be a distraction from other pressing issues.  

My real concern with the method is that somebody may change
chipsets for the USB2 to IDE interface, and the hotswap will no
longer work with the new chipset.  Or the USB mass storage module
might get "improved".  Thus a direct IDE-chipset-driven hotswap
scheme is still desirable, but perhaps not with the same urgency.

Keith

-- 
Keith Lofstrom           keithl@ieee.org         Voice (503)-520-1993
KLIC --- Keith Lofstrom Integrated Circuits --- "Your Ideas in Silicon"
Design Contracting in Bipolar and CMOS - Analog, Digital, and Scan ICs
