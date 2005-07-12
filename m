Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVGLW12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVGLW12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVGLWYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:24:48 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:37602 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262484AbVGLWYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:24:17 -0400
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: synaptics touchpad not recognized by Xorg X server with recent -mm kernels
References: <20050712172504.GD24820@gamma.logic.tuwien.ac.at>
	<m3fyujq5cf.fsf@telia.com>
	<20050712201121.GA5587@gamma.logic.tuwien.ac.at>
From: Peter Osterlund <petero2@telia.com>
Date: 13 Jul 2005 00:22:42 +0200
In-Reply-To: <20050712201121.GA5587@gamma.logic.tuwien.ac.at>
Message-ID: <m364vfpsul.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> writes:

> On Die, 12 Jul 2005, Peter Osterlund wrote:
> > What's the output from "cat /proc/bus/input/devices"?
> 
> bad (rc2-mm2)
> $ cat /proc/bus/input/devices 

> I: Bus=0011 Vendor=0002 Product=0007 Version=0000
> N: Name="SynPS/2 Synaptics TouchPad"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse0 event1 
> B: EV=b 
> B: KEY=6420 0 7000f 0 0 0 0 0 0 0 0 
> B: ABS=11000003 

Looks correct. My guess is that something is wrong with your device
nodes. What's the output from "ls -l /dev/input/event*"?

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
